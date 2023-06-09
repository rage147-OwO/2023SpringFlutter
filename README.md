## 2023SpringFlutter 
##### UI/UX 프로그래밍 [02] Flutter 앱 개발 프로젝트
기간: 2023.05.01~2023.05.20
PyTorch 기반 실시간 객체 감지 모델 테스트 앱 

------------

### 1. 프로젝트 제안서

##### 1. 프로그램 개요 및 설명
- PC 환경에서는 성능에 제약이 적지만, 모바일 환경에서는 객체 감지에 제한이 있습니다. 이에 객체 감지 모델의 경량화가 필수적입니다. 따라서 서로 다른 모바일 환경에서 객체 감지 모델을 테스트하기 위한 앱을 개발합니다.
- Flutter를 사용하여 PyTorch 기반의 실시간 객체 감지 모델을 모바일 환경에서 실행할 수 있는 앱을 구현합니다.
- 모바일 기기에서 서로 다른 객체 감지 모델을 테스트하기 위한 앱을 개발합니다.

##### 2. 전체 구조도 설명(실제 구조와 다를 수 있음)
- MyApp 클래스: Flutter의 기본 클래스로 앱의 최상위 위젯을 정의하는 클래스입니다. 화면 구성, 라우팅, 앱 전반적인 기능을 구현합니다.
- CameraView 클래스: 카메라 뷰를 구성하는 클래스로, 카메라 기능을 구현합니다.
- DetectionModel 클래스: PyTorch 기반의 실시간 객체 감지 모델 클래스로, 모델 학습 및 추론 기능을 구현합니다.
- DetectionSettings 클래스: 모델 설정과 관련된 클래스로, 모델 선택, 입력 이미지 크기 등의 설정을 구현합니다.
- ObjectDetectionResult 클래스: 객체 감지 결과를 나타내는 클래스로, 객체 감지된 이미지와 객체 정보를 포함합니다.
- ObjectDetectionView 클래스: 객체 감지 결과를 보여주는 뷰 클래스로, ObjectDetectionResult를 이용하여 결과를 출력합니다.
- UI/UX 클래스: 화면 구성에 필요한 클래스들로, 버튼, 이미지, 텍스트 등의 UI 요소를 구현합니다.

##### 3. 주요 기능 설명
- 카메라 실행 및 실시간 프레임 캡처 기능
- 캡처한 프레임마다 객체 감지 기능

##### 4. 팀원 역할 분담
- 임준택: PM, 모델 및 앱 구현, UI 담당

##### 5. 개발 일정
- 7주차: 프로그램 구조 설계 및 UI/UX 디자인
- 8-9주차: 카메라 기능 구현
- 10-11주차: PyTorch 모델 연동
- 12주차: 모델별 설정 UI 구현
- 13주차: 모델별 설정 기능 구현
- 14주차: 발표 자료 준비, 보고서 작성

------------
### 3. 프로젝트 발표 자료 및 결과 보고서
#### 0. 시연 영상 [링크](https://www.youtube.com/watch?v=HKiJsClo43w)
#### 1. 프로그램 개요 및 설명
- PC 환경에서는 성능에 제약이 적지만, 모바일 환경에서는 객체 감지에 제한이 있습니다. 이에 객체 감지 모델의 경량화가 필수적입니다. 따라서 서로 다른 모바일 환경에서 객체 감지 모델을 테스트하기 위한 앱을 개발합니다.
- Flutter를 사용하여 PyTorch 기반의 실시간 객체 감지 모델을 모바일 환경에서 실행할 수 있는 앱을 구현합니다.
- 모바일 기기에서 서로 다른 객체 감지 모델을 테스트하기 위한 앱을 개발합니다.

#### 2. 전체 구조도 설명
- 사용한 플러터 패키지:
  - file_picker: ^5.3.0 (파일 선택 기능 제공 패키지)
  - camera: ^0.9.8+1 (실시간 미리보기 기능 제공 패키지)
  - flutter_pytorch (torchscript 파일로 객체 감지 기능 제공 패키지)
  - performance: ^0.1.1 (UI와 다음 프레임 레이턴시 모니터링을 위한 패키지)

- 클래스 구조도
  - 자세한 구조도는 아래 이미지를 참고해주세요.
  ![Class UML](https://raw.githubusercontent.com/rage147-OwO/2023SpringFlutter/main/classUML.svg?token=GHSAT0AAAAAACBC3VJXMNE464BTIID7RS6EZDLTTFA)
  
  주요 클래스:
  - ModelManager: 모델을 관리하는 클래스로, 모델의 저장 위치와   JSON의 저장 위치 설정, 모델 저장, 로드, 삭제 기능을 제공합니다. 디버그용으로 모든 모델 파일을 출력하는 기능도 있습니다.
  - Model: 모델을 관리하기 위한 객체로, 이름, 클래스, 입력 이미지 크기 등의 정보를 포함합니다. JSON 직렬화 및 역직렬화를 위한 기능도 제공합니다.
  - ModelManagementApp, ModelListScreen, _ModelListScreenState: 모델 리스트를 표시하는 위젯으로, 초기화 시 모델 리스트를 로드하고, 모델 저장, 삭제 기능을 버튼으로 제공합니다. 모델을 선택하면 RunModelByCamera 위젯을 빌드합니다.
  - RunModelByCamera, _RunModelByCameraState: 선택한 모델로 실시간 객체 감지를 수행하는 위젯입니다. 초기화 시 카메라 뷰를 빌드하고, 결과를 콜백으로 받아 바운딩 박스 위젯을 업데이트하고, 신뢰도를 업데이트합니다.
  - CameraViewSingleton: 실제 화면 크기를 계산하기 위한 싱글톤 클래스입니다. camera_view와 BoxWidget에서 사용됩니다.
  - BoxWidget: flutter_pytorch에서 제공하는 결과에 따라 바운딩 박스를 생성하는 위젯입니다.
  - CameraView: flutter_pytorch에서 감지된 결과를 콜백으로 받기 위한 카메라 뷰 위젯입니다.
  - _CameraViewState: 카메라 초기화, 모델 로드, 카메라에서 이미지를 받아올 때마다 flutter_pytorch에 결과를 요청하고, _RunModelByCameraState에게 콜백으로 전달합니다.
  - flutter_pytorch: 객체 감지를 수행하는 flutter_pytorch 라이브러리입니다. 이미지로부터 감지한 결과를 업데이트합니다.

#### 3. 주요 기능 설명
- torchscript 파일의 로드, 저장, 삭제 기능
- 선택한 모델을 사용하여 실시간 객체 감지 기능
- 객체 감지 중 다음 프레임의 레이턴시를 모니터링하는 기능

#### 4. 프로그램 실행 화면 캡처 설명
- 시연 영상: [링크](https://www.youtube.com/watch?v=HKiJsClo43w)
- 아래는 프로그램 실행 화면의 캡처 이미지 및 설명입니다:
  
  ![이미지](https://github.com/rasbt/deeplearning-models/assets/96696114/9c0b6252-e75f-44bb-8fee-f142a1b9a6ad)
  
  모델 리스트 화면입니다.

  ![이미지](https://github.com/rasbt/deeplearning-models/assets/96696114/4f99e285-8789-4888-91d2-1e4e00f37523)
  
  객체 감지 결과와 신뢰도, 프레임 레이턴시를 표시하는 화면입니다.

#### 5. 개인 의견
- 현재는 torchscript를 사용하여 객체 감지만 가능하지만, 나중에는 분류나 TFLite와 같은 다른 라이브러리도 테스트할 수 있는 종합적인 앱으로 확장할 예정입니다.

#### 6. 알려진 이슈
- 파일 크기가 100MB를 초과하는 경우 파일 선택 후 복사가 정상적으로 작동하지 않습니다.
- iOS는 호환되지 않습니다. PyTorch 패키지가 안드로이드 C++ 네이티브 코드로 동작합니다.

#### 7. 예상 질문과 답변
- 앱을 개발하면서 가장 어려웠던 부분은 어디인가요?
  - 안드로이드에서 절대 경로로 파일을 가져오기 위해서는 file_picker 패키지로는 불가능하며, 네이티브 코드로 구현해야 했습니다. 대신 파일을 Appdata 경로에 복사하는 방법을 사용했습니다.
  - 처음에는 각 모델마다 modelInfo.txt를 만들어 모델 관리 코드를 작성했지만, 마음에 들지 않아 다시 작성했습니다.
- 앱을 사용하는 동안 발생한 예외 상황이나 오류 처리 방법에 대해 설명해주세요.
  - 디버깅은 안드로이드 스튜디오에서 로그를 확인하였고, 앱 내에서 디버깅할 수 있는 방법은 없습니다. 알려지지 않은 이슈에 대한 대응이 어려울 수 있습니다.
- 사용된 테스트 모델은 무엇인가요?
  - 시연 영상에서 사용된 모델은 모두 yolov5이며, 첫 번째는 직접 학습한 자동차 감지 모델이고, 두 번째는 coco 데이터셋의 기본 모델입니다.
- 모델을 추가할 때 설정을 잘못하면 어떻게 되나요?
  - 클래스 레이블 수가 일치하지 않거나 입력 이미지 크기가 일치하지 않는 경우에는 바운딩 박스가 감지되지 않습니다.
- 앱은 어디에서 다운로드할 수 있나요?
  - [GitHub 링크](https://github.com/rage147-OwO/flutter_objectdetectionBypytorch)에서 앱을 다운로드할 수 있습니다.
