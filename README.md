## 2023SpringFlutter 
##### UI/UX프로그래밍[02] flutter 앱개발 프로젝트
기간 : 2023.05.01~2023.05.20
PyTorch기반 실시간 객체 감지 모델 테스트 앱 
<br><br>


------------

### 1. 프로젝트 제안서

##### 1. 프로그램 개요 및 설명
- PC환경에서는 성능에 제약의 적으나, 모바일 환경에서는 객체감지에 있어 성능에 제한이 있음. 그렇기에 모델의 경량화가 필수불가결인데, 서로 다른 모바일 환경에서 객체감지 모델 테스트를 위한 앱
- Flutter를 사용하여 PyTorch 기반 실시간 객체 감지 모델을 모바일환경에서 구동 할 수 있는 앱 구현
- 모바일 기기에서 서로 다른 객체감지모델 테스트를 위한 앱

##### 2. 전체 구조도 설명(실제 구조도와는 다름)
- MyApp 클래스
 Flutter의 기본 클래스로 앱의 최상위 위젯을 정의하는 클래스
 화면 구성 및 라우팅, 앱 전반적인 기능 구현

-  CameraView 클래스
카메라 뷰를 구성하는 클래스
카메라 기능 구현

- DetectionModel 클래스
PyTorch 기반의 실시간 객체 감지 모델 클래스
모델 학습 및 추론 기능 구현

- DetectionSettings 클래스
모델 설정 관련 클래스
모델 선택, 입력 이미지 크기 등의 설정 구현

- ObjectDetectionResult 클래스
객체 감지 결과 클래스
객체 감지된 이미지와 객체 정보를 포함하는 클래스

- ObjectDetectionView 클래스
객체 감지 결과를 보여주는 뷰 클래스
ObjectDetectionResult를 이용하여 결과 출력

- UI/UX 클래스
화면 구성에 필요한 클래스들
버튼, 이미지, 텍스트 등의 UI 요소 구현


























##### 3. 주요 기능 설명
- 카메라를 실행하여 실시간으로 프레임 캡쳐
- 캡쳐한 프레임마다 객체를 감지

##### 4. 팀원 역할 분담
- 임준택: PM, 모델, 앱 구현, UI 담당

##### 5. 개발 일정
- 7주차: 프로그램 구조 설계 및 UI/UX 디자인
- 8-9주차: 카메라 기능 구현
- 10-11주차: PyTorch모델 연동
- 12주차: 모델별 설정 UI 구현
- 13주차: 모델별 설정 기능 구현
- 14주차: 발표자료 준비, 보고서 작성















------------
### 3. 프로젝트 발표자료&결과보고서
#### 0. 시연영상 https://www.youtube.com/watch?v=HKiJsClo43w
#### 1. 프로그램 개요 및 설명
- PC환경에서는 성능에 제약의 적으나, 모바일 환경에서는 객체감지에 있어 성능에 제한이 있음. 그렇기에 모델의 경량화가 필수불가결인데, 서로 다른 모바일 환경에서 객체감지 모델 테스트를 위한 앱
- Flutter를 사용하여 PyTorch 기반 실시간 객체 감지 모델을 모바일환경에서 구동 할 수 있는 앱 구현
- 모바일 기기에서 서로 다른 객체감지모델 테스트를 위한 앱

#### 2. 전체 구조도 설명
- 사용한 플러터 패키지
 - file_picker: ^5.3.0 #파일 선택 기능 제공 패키지
 - camera: ^0.9.8+1 #실시간 preview를 제공하는 패키지
 - flutter_pytorch #torchscript파일로 검출 기능 제공하는 패키지
  - performance: ^0.1.1 #UI와 다음 프레임 레이턴시를 모니터링 하기 위한 패키지
- 클래스 구조도
![](https://raw.githubusercontent.com/rage147-OwO/2023SpringFlutter/main/classUML.svg?token=GHSAT0AAAAAACBC3VJXMNE464BTIID7RS6EZDLTTFA)

```
model_manager.dart
ModelManager //모델을 관리하는 클래스, 모델의 저장 위치와 모델리스트JSON의 저장 위치 Setting, SaveModels, loadmodels, deleteModelFile, 디버그용 printAllModelFiles
Model //모델 관리용 객체. name, classes, inputSize, nc, description, filePath, toJson, fromJson

main.dart
ModelManagementApp
ModelListScreen 
_ModelListScreenState //모델 리스트 위젯, initState에서 loadlist, button으로 savemodel, deletemodel, listOntap시 RunModelByCamera위젯 build

RunModelByCamera.dart
RunModelByCamera(model) //model을 생성자로 가져옴
_RunModelByCameraState // initState()에서 CameraView위젯 build, result를 콜백받고 바운딩박스 위젯 업데이트, 신뢰도 업데이트

camera_view_singleton.dart
CameraViewSingleton //camera_view와 BoxWidget에서 실제 화면 사이즈를 계산하기 위한 singleton

box_widget.dart
BoxWidget //flutter_pytorch패키지에서 result 따라 Container로 바운딩 박스 생성

camera_view.dart
CameraView //flutter_pytorch에서 감지된 result를 callback받음

_CameraViewState //카메라 initialize, loadmodel, 카메라에서 이미지를 받아올때마다 flutter_pytorch에 result 요청, _RunModelByCameraState에게 callback

flutter_pytorch //flutter_pytorch라이브러리, 이미지로 감지 후 result업데이트

```

#### 3. 주요 기능 설명
- torchscript 파일 로드, 저장, 삭제
- 리스트에서 선택한 Model로 실시간 객체 감지
- 객체 감지 중, 다음 프레임 레이턴시 모니터링

#### 4. 프로그램 실행 화면 캡쳐 설명
https://www.youtube.com/watch?v=HKiJsClo43w

![image](https://github.com/rasbt/deeplearning-models/assets/96696114/9c0b6252-e75f-44bb-8fee-f142a1b9a6ad)
modelList

![image](https://github.com/rasbt/deeplearning-models/assets/96696114/4f99e285-8789-4888-91d2-1e4e00f37523)
objectdetection&confidence, fps latency

#### 5. 개인의견
- 현재 torchscript로 objectdetection만 가능하지만, 이후 classification나 tflite같은 다른 라이브러리도 가능한 종합 테스트 앱으로 사용할 예정.

