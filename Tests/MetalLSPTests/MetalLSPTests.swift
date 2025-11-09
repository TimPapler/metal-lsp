import XCTest
@testable import MetalLanguageServer
@testable import MetalCore

final class MetalLSPTests: XCTestCase {

    func testMetalBuiltinsNotEmpty() {
        let completions = MetalBuiltins.getAllCompletions()
        XCTAssertFalse(completions.isEmpty, "Built-ins should not be empty")
    }

    func testMetalBuiltinsContainsFloat4() {
        let completions = MetalBuiltins.getAllCompletions()
        let hasFloat4 = completions.contains { $0.label == "float4" }
        XCTAssertTrue(hasFloat4, "Built-ins should contain float4 type")
    }

    func testMetalBuiltinsContainsKernelKeyword() {
        XCTAssertTrue(MetalBuiltins.keywords.contains("kernel"))
        XCTAssertTrue(MetalBuiltins.keywords.contains("vertex"))
        XCTAssertTrue(MetalBuiltins.keywords.contains("fragment"))
    }

    func testPositionEquality() {
        let pos1 = Position(line: 5, character: 10)
        let pos2 = Position(line: 5, character: 10)
        let pos3 = Position(line: 5, character: 11)

        XCTAssertEqual(pos1, pos2)
        XCTAssertNotEqual(pos1, pos3)
    }

    func testRangeCreation() {
        let start = Position(line: 0, character: 0)
        let end = Position(line: 0, character: 5)
        let range = Range(start: start, end: end)

        XCTAssertEqual(range.start, start)
        XCTAssertEqual(range.end, end)
    }

    func testDocumentManager() {
        let manager = DocumentManager()
        let uri = "file:///test.metal"
        let text = "kernel void test() {}"

        manager.openDocument(uri: uri, text: text, version: 1)

        let doc = manager.getDocument(uri: uri)
        XCTAssertNotNil(doc)
        XCTAssertEqual(doc?.text, text)
        XCTAssertEqual(doc?.version, 1)

        manager.closeDocument(uri: uri)
        let closedDoc = manager.getDocument(uri: uri)
        XCTAssertNil(closedDoc)
    }

    func testDocumentLineAccess() {
        let manager = DocumentManager()
        let uri = "file:///test.metal"
        let text = "line 0\nline 1\nline 2"

        manager.openDocument(uri: uri, text: text, version: 1)

        let doc = manager.getDocument(uri: uri)
        XCTAssertEqual(doc?.line(at: 0), "line 0")
        XCTAssertEqual(doc?.line(at: 1), "line 1")
        XCTAssertEqual(doc?.line(at: 2), "line 2")
        XCTAssertNil(doc?.line(at: 3))
    }

    func testJSONValueEncoding() throws {
        let value = JSONValue.string("test")
        let encoded = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(JSONValue.self, from: encoded)

        if case .string(let str) = decoded {
            XCTAssertEqual(str, "test")
        } else {
            XCTFail("Expected string value")
        }
    }

    func testRequestIDEncoding() throws {
        let stringID = RequestID.string("test-123")
        let numberID = RequestID.number(42)

        let stringData = try JSONEncoder().encode(stringID)
        let numberData = try JSONEncoder().encode(numberID)

        let decodedString = try JSONDecoder().decode(RequestID.self, from: stringData)
        let decodedNumber = try JSONDecoder().decode(RequestID.self, from: numberData)

        XCTAssertEqual(decodedString, stringID)
        XCTAssertEqual(decodedNumber, numberID)
    }
}
