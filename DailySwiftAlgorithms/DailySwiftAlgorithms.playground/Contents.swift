
protocol MyProtocol {
    func testFunc()
}

extension MyProtocol {
    func testFunc() {
        print("11111111")
    }
}

class Man: MyProtocol {
    func testFunc() {
        print("22222222")
    }
}

let m1 = Man()
let m2: MyProtocol = Man()

m1.testFunc()
m2.testFunc()
print("3333333")
