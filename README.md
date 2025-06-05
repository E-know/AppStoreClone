

# AppStore Search Clone (검색 기능 클론)

이 프로젝트는 iOS App Store의 **검색 기능**만 클론한 예제입니다.  
단순한 UI 복제에 그치지 않고, **MVI 아키텍처 패턴**을 기반으로 설계되어 구조적이고 확장 가능한 코드를 지향합니다.

## 🔧 기술 스택 및 아키텍처

- **패턴**: MVI (Model–View–Intent)
  - View → Intent → State → View 구조로 View가 상태에 따라 자동으로 갱신됩니다.
- **비즈니스 로직 처리**:  
  Intent 내부에서 외부 종속성 (네트워크 등)과 연결할 때는 다음 구조를 따릅니다:
  ```
  Intent → Worker → Repository → Service
  ```

## 🚀 실행 방법

1. 해당 프로젝트를 클론합니다.
2. `AppStoreSearchService`에서 사용하는 API 키가 있다면 설정합니다.
3. `SearchView`를 진입점으로 실행하면 됩니다.

## 🎯 목표

- App Store 검색 UI의 사용성과 동작을 최대한 비슷하게 구현

## 📝 참고 사항

- API는 Apple 공식 App Store Search API를 사용하거나 이를 모방한 Mock API를 사용합니다.
- UI는 SwiftUI 기반으로 구현되어 있으며, MVVM보다 더 명확한 단방향 흐름을 갖도록 설계되어 있습니다.
