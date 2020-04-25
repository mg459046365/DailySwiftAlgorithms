//
//  CrashCollection.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/25.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
import MachO

// MARK: - 用于捕获OC的NSException导致的异常崩溃

func OC_SetUncaughtExceptionHandler() {
    #warning("该方式在纯swift项目不会生效")
    NSSetUncaughtExceptionHandler(OC_UncaughtExceptionHandler(_:))
}

func OC_UncaughtExceptionHandler(_ exception: NSException) {
    // 异常的堆栈信息
    let stack = exception.callStackSymbols
    // 异常原因
    let reason = exception.reason ?? ""
    // 异常名称
    let name = exception.name
    var crash = "Stack:\n"
    crash += "slideAdress:0x\(CalculateAddress())x\r\n"
    crash += "\r\n\r\n name:\(name) \r\n reason:\(reason) \r\n \(stack.joined(separator: "\r\n")) \r\n\r\n"
    // 将收集的信息，保存到本地文件，然后上传到云端。
    CrashCollection.saveCrash(withType: .NSException, info: crash)
}

/// 获取偏移量地址
func CalculateAddress() -> Int {
    var slide = 0
    for i in 0 ..< _dyld_image_count() {
        let point = _dyld_get_image_header(i)
        if let type = point?.pointee.filetype, type == MH_EXECUTE {
            slide = _dyld_get_image_vmaddr_slide(i)
            break
        }
    }
    return slide
}

// MARK: - 用于搜集signal异常导致的崩溃(包括Swift及OC)

/// 触发信号后操作
func SignalExceptionHandler(_ signal: Int32) {
    var crash = "Stack:\n"
    // 增加偏移地址
    crash += "slideAdress:0x\(CalculateAddress())x\r\n"
    // 增加错误信息
    Thread.callStackSymbols.forEach {
        crash += "\($0)\r\n"
    }
    // 将收集的信息，保存到本地文件，然后上传到云端。
    CrashCollection.saveCrash(withType: .signal, info: crash)
    exit(signal)
}

/// 注册信号
func RegisterSignalHandler() {
    // 如果在运行时遇到意外情况，Swift代码将以SIGTRAP此异常类型终止，例如：
    // 1.具有nil值的非可选类型
    // 2.一个失败的强制类型转换
    // 查看Backtraces以确定遇到意外情况的位置。附加信息也可能已被记录到设备的控制台。
    // 您应该修改崩溃位置的代码，以正常处理运行时故障。例如，使用可选绑定而不是强制解开可选的。
    signal(SIGABRT, SignalExceptionHandler(_:))
    signal(SIGSEGV, SignalExceptionHandler(_:))
    signal(SIGBUS, SignalExceptionHandler(_:))
    signal(SIGTRAP, SignalExceptionHandler(_:))
    signal(SIGILL, SignalExceptionHandler(_:))
    signal(SIGINT, SignalExceptionHandler(_:))
}

func UnregisterSignalHandler() {
    signal(SIGINT, SIG_DFL)
    signal(SIGSEGV, SIG_DFL)
    signal(SIGTRAP, SIG_DFL)
    signal(SIGABRT, SIG_DFL)
    signal(SIGILL, SIG_DFL)
    signal(SIGBUS, SIG_DFL)
}

// MARK: - 收集crash

enum CrashType: String {
    case signal = "signaCrash"
    case NSException = "NSExceptionCrash"
}

/// Crash处理总入口,请留意不要集成多个crash捕获，NSSetUncaughtExceptionHandler可能会被覆盖.NSException的crash也会同时生成一个signal异常信息
func crashHandler(_ handler: @escaping ([String]) -> Void) {
    DispatchQueue.global().async {
        let infos = CrashCollection.readAllCrashInfo()
        if !infos.isEmpty {
            // 如果崩溃信息不为空，则对崩溃信息进行下一步处理
            handler(infos)
        }
        CrashCollection.deleteAllCrashFile()
    }
    // 注册signal,捕获相关crash
    RegisterSignalHandler()
    // 注册NSException,捕获相关crash
    OC_SetUncaughtExceptionHandler()
}

struct CrashCollection {
    /// 保存崩溃信息
    static func saveCrash(withType type: CrashType, info: String) {
        guard var filePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        filePath += "/" + type.rawValue
        if !FileManager.default.fileExists(atPath: filePath) {
            try? FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd-HHmmss"
        let dateString = dateFormatter.string(from: Date())
        let crashFilePath = filePath + "/" + dateString + ".log"
        try? info.write(toFile: crashFilePath, atomically: true, encoding: .utf8)
    }

    /// 获取所有的log列表
    static func crashFiles(withType type: CrashType) -> [String] {
        let dir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let crashPath = dir + "/" + type.rawValue
        let fileManager = FileManager.default
        guard let list = try? fileManager.contentsOfDirectory(atPath: crashPath) else { return [] }
        var files = [String]()
        for name in list {
            if let _ = name.range(of: ".log") {
                files.append(crashPath + "/" + name)
            }
        }
        return files
    }

    /// 读取所有的崩溃信息
    static func readAllCrashInfo() -> [String] {
        var infos = [String]()
        for path in crashFiles(withType: .signal) {
            if let content = try? String(contentsOfFile: path, encoding: .utf8) {
                infos.append(content)
            }
        }
        for path in crashFiles(withType: .NSException) {
            if let content = try? String(contentsOfFile: path, encoding: .utf8) {
                infos.append(content)
            }
        }

        return infos
    }

    /// 删除所有崩溃信息文件信息
    static func deleteAllCrashFile() {
        for path in crashFiles(withType: .signal) {
            try? FileManager.default.removeItem(atPath: path)
        }
        for path in crashFiles(withType: .NSException) {
            try? FileManager.default.removeItem(atPath: path)
        }
    }

    /// 删除单个崩溃信息文件
    static func deleteCrash(withType type: CrashType, fileName: String) {
        let dir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let filePath = dir + "/" + type.rawValue + "/" + fileName
        let fileManager = FileManager.default
        try? fileManager.removeItem(atPath: filePath)
    }

    /// 读取单个文件崩溃信息
    static func readCrash(withType type: CrashType, fileName: String) -> String? {
        let dir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let filePath = dir + "/" + type.rawValue + "/" + fileName
        let content = try? String(contentsOfFile: filePath, encoding: .utf8)
        return content
    }
}
