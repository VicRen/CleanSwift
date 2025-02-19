//
//  LoadInitialDataUseCaseTests.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/19.
//

import XCTest
import Combine
@testable import CleanSwift

class LoadInitialDataUseCaseTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    class MockSplashRepository: SplashRepository {
        var shouldLoadData = true // 控制模拟的行为
        var mockError: Error?

        func loadData() -> AnyPublisher<Void, Error> {
            if let error = mockError {
                return Fail(error: error).eraseToAnyPublisher()
            } else if shouldLoadData {
                return Just(())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                //模拟一个错误
                return Fail(error: NSError(domain: "MockSplashRepository", code: -1)).eraseToAnyPublisher()
            }
        }
    }
    
    func testLoadInitialDataUseCase_whenFirstLaunch_shouldSucceed() {
        // Arrange (准备)
        let mockRepository = MockSplashRepository() // 不需要加载数据
        //将首次启动设置为true.  因为这里无法直接操作UserDefaults, 所以直接修改mock repository的行为
        mockRepository.shouldLoadData = false // 模拟首次启动，不加载数据
        let useCase = LoadInitialDataUseCase(repository: mockRepository)
        let expectation = XCTestExpectation(description: "UseCase should complete successfully")

        // Act (执行)
        useCase.execute(input: ()) { result in
            // Assert (断言)
            switch result {
            case .success:
                expectation.fulfill() // 标记期望达成
            case .failure:
                XCTFail("UseCase should not fail for first launch")
            }
        }

        wait(for: [expectation], timeout: 1.0) // 等待异步操作完成 (设置一个合理的超时时间)
    }
    
}
