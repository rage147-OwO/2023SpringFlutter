# UI/UX프로그래밍[02] 20191240임준택 
# 프로젝트 제안서: PyTorch기반 실시간 객체 감지 모델 테스트 앱 

## 1. 프로그램 개요 및 설명
- PC환경에서는 성능에 제약의 적으나, 모바일 환경에서는 객체감지에 있어 성능에 제한이 있음. 그렇기에 모델의 경량화가 필수불가결인데, 서로 다른 모바일 환경에서 객체감지 모델 테스트를 위한 앱
- Flutter를 사용하여 PyTorch 기반 실시간 객체 감지 모델을 모바일환경에서 구동 할 수 있는 앱 구현
- 모바일 기기에서 서로 다른 객체감지모델 테스트를 위한 앱

## 2. 전체 구조도 설명
### MyApp 클래스
- Flutter의 기본 클래스로 앱의 최상위 위젯을 정의하는 클래스
- 화면 구성 및 라우팅, 앱 전반적인 기능 구현

### CameraView 클래스
- 카메라 뷰를 구성하는 클래스
- 카메라 기능 구현

### DetectionModel 클래스
- PyTorch 기반의 실시간 객체 감지 모델 클래스
- 모델 학습 및 추론 기능 구현

### DetectionSettings 클래스
- 모델 설정 관련 클래스
- 모델 선택, 입력 이미지 크기 등의 설정 구현

### ObjectDetectionResult 클래스
- 객체 감지 결과 클래스
- 객체 감지된 이미지와 객체 정보를 포함하는 클래스

### ObjectDetectionView 클래스
- 객체 감지 결과를 보여주는 뷰 클래스
- ObjectDetectionResult를 이용하여 결과 출력

### UI/UX 클래스
- 화면 구성에 필요한 클래스들
- 버튼, 이미지, 텍스트 등의 UI 요소 구현

## 3. 주요 기능 설명
- 카메라를 실행하여 실시간으로 프레임 캡쳐
- 캡쳐한 프레임마다 객체를 감지

## 4. 팀원 역할 분담
- 임준택: PM, 모델, 앱 구현, UI 담당

## 5. 개발 일정
- 7주차: 프로그램 구조 설계 및 UI/UX 디자인
- 8-9주차: 카메라 기능 구현
- 10-11주차: PyTorch모델 연동
- 12주차: 모델별 설정 UI 구현
- 13주차: 모델별 설정 기능 구현
- 14주차: 마무리 작업 및 테스트, 앱 출시 준비

# 팀프로젝트 발표평가
  점수기준
  개요설명(5)	전체 구조도 설명(10)	주요 기능 설명(10)	프로그램시연(5)	발표력및발표시간(5)	

# 결과보고서 제출
UI/UX프로그래밍 결과보고서 제출 안내
1. 결과보고서 내용
	1. 프로그램 개요 및 설명
	2. 전체 구조도 설명
	3. 주요 기능 설명
	4. 프로그램 실행 화면 캡쳐 설명
	5. (optional) 개인의견
	- 발표자료를 기반으로 작성 가능
2. 제출 내용
	- 결과보고서 + 전체프로젝트(소스코드) 압축본
	- 소스코드에 대한 설명 포함(문서 또는 코드상)
3. 제출 기한
	- 06.06.(화) 까지



![](https://raw.githubusercontent.com/rage147-OwO/2023SpringFlutter/main/lLTDSzis4BthLs1qIYPL3proF78ioMxIshL7SfiZ1mHNCXeGu02W53NDVoy-O0PYH8vaDBbenBV0xiFk0nPugpIMkgdOI85675UWQanW1JMMM0k9icmq8WmhXSODpR8rQxG6UL_y3KGlG9jVAdYM5U9JlgFb1lJFfN6OPJFnwOFx7gFF8uJUB44rJ7Vc8UbGQvyB9kGbCdv0kVyMB8HWI3s9tG.svg?token=GHSAT0AAAAAAB5HKWBVV4VANPYMP25UYPIQZDKDOWA)

