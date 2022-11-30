# Uniletter_iOS
유니레터 iOS

<img width="192" alt="logo" src="https://user-images.githubusercontent.com/75382687/176232693-a045051f-e9ae-40a5-a24a-3690a81f5b11.png">
<a href="https://apps.apple.com/kr/app/%EC%9C%A0%EB%8B%88%EB%A0%88%ED%84%B0/id6444344639">유니레터(앱스토어)</a>

## 구성원

||이름|깃헙|
|---|---|---|
|1|권오준|<a href=https://github.com/vhzkclq0705> vhzkclq0705 </a>|
|2|임현규|<a href=https://github.com/leemhyungyu> leemhyungyu </a>|

## 개요

- 간식나눔 이제 놓치지 말아요!
- 자주 보는 행사 정보는 저장해두고 다시 보아요!
- 행사 오픈 또는 마감 전에 푸시알림으로 알려드려요!
- 홍보를 어디에 해야할 지 고민할 때, 유니레터에서 작성해요!
- 동아리/소모임, 학생회, 간식나눔, 대회/공모전, 스터디, 구인 등, 이제는 유니레터에서!

## 프로젝트 구조

유니레터는 `MVVM` 패턴을 적용하였습니다.   
(프레임워크는 UIKit만을 사용하였고 Rx 또는 Combine을 사용하지 않아 완전하지 않음)

<details>
  <summary> 수정 날짜: 22.12.01 </summary>
  <div markdown="0">

### Uniletter

> Supporting Files
>> Info.plist와 소셜 로그인, 푸시 알림 등을 위한 Entity 파일

> Resources
>> 이미지, 아이콘을 위한 Assets

> Sources
>> Managers
>>> 로그인 관련 파일들.

>> Presentation
>>> 여러 화면의 View, ViewController, ViewModel 파일들

>> Utilities
>>> 유틸리티 파일들

>> Model
>>> 다양한 Model 구조체 파일들

>> Networking
>>> 네트워킹 파일들

>> Extensions
>>> 다양한 class의 확장 파일들

>> AppDelegate

>> SceneDelegate

  </div>
</details>

## 업데이트 로그

### 2022.12.01 v1.1.0
- <b>이벤트, 저장 목록 페이징</b>
- 글쓰기 이미지 등록 안내 문구 수정
- 댓글창 테이블뷰 바로 보이게 수정
- 이미지 비율 수정
- UI 일부 수정

### 2022.11.18 v1.0.0
- 배포 완료
