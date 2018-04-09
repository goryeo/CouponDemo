# SpringBoot Demo Web

### 1. 프로젝트 구현 환경

- jdk1.8.0_161

- Spring-Boot

- Spring Tool Suite (Version: 3.9.3.RELEASE)

  > Maven, MyBatis, Lombok, Devtools, log4jdbc, jdbc

- DB : MySQL Community Server 5.7.21

- Front-end : Jsp, Jstl, JQeury, Bootstrap

- OS : Windows 10

- 기타 도구 : Fiddler 4, Postman, Github

### 2. 프로젝트 실행 방법

- 구현환경 설정 후 아래 Git 주소에서 프로젝트 다운로드
- 아래에 있는 테이블 스키마 MySQL에 추가
- `https://github.com/goryeo/CouponDemo`
- STS - File - Import - General - Existing Projects into Workspace
- 다운 받은 프로젝트 폴더 선택 Finish
- Run As - Spring Boot App 으로 빌드
- URL 호출 : `http://localhost:8080/coupon/list`

### 3. 문제 해결 전략

- 요구사항 분석

- 구현환경 설정

  > 자바 스프링부트, MySQL 활용

- 초기 프로젝트 생성시 Maven 선택 및 아래의 dependency 추가

  > Web, MyBatis, Lombok, jdbc

- MySQL 에 쿠폰 테이블 스키마 생성

- DB 연동 구현 및 테스트

- 쿠폰 리스트에 필요한 DTO 구성
  > DTO 변수명 카멜표기법 필수

- 쿠폰 기능에 필요한 DB 쿼리 생성(Coupon.xml)

  > 1) 쿠폰 전체 개수 조회
  >
  > 2) 쿠폰 리스트 조회
  >
  > 3) 쿠폰 생성
  >
  > 4) 쿠폰 번호 생성
  >
  > 5) 이메일주소 중복 체크
  >
  > 6) 쿠폰 번호 중복 체크 

- DAO와 쿼리 작성된 XML 매핑

- 쿠폰 서비스 인터페이스 생성, 쿠폰 서비스 구현체 생성

  > 서비스 구현체에 각 기능별 DAO 함수 호출

- 쿠폰 컨트롤러의 쿠폰 리스트 기능 추가

- 쿠폰 컨트롤러의 기능을 활용하여 JSP 리스트기능 추가

- Jsp에 Bootstrap 및 리스트 페이징 적용

- 쿠폰 컨트롤러의 쿠폰 생성 기능 추가

  > 쿠폰 생성은 MySQL의 Rand() 함수를 활용 (조건 : 16자리 + 알파벳과 숫자)
  >
  > 쿠폰 인터페이스 구현체에  쿠폰 생성 시 필요한 중복 체크로직 추가
  >
  > 쿠폰 생성기능 실행 시 쿠폰은 되지 않으나 에러가 발생하지 않아 디버깅에 어려움
  >
  > 소스반영시 자동 변경 기능과 빌드 시 쿼리 실행 로그를 알 수 있도록 Devtools, log4jdbc 추가

- 초기 form 전송 방식에서 Ajax 호출로 수정

  > Jsp의 이메일 유효성 체크 로직 추가(빈값 + 정규식)
  >
  > json을 이용한 비동기로 컨트롤러에 요청
  >
  > 컨트롤러에서는 입력받은 이메일을 이용하여 쿠폰생성 함수 서비스 호출 후 json 포맷으로 응답
  >
  > 원활한 디버깅을 위해 Fiddler 4, Postman 활용

### 4. 쿠폰 테이블 스키마

*CREATE TABLE TCouponMst (*

*CouponID int(11) NOT NULL AUTO_INCREMENT,*

*CouponNo varchar(100) NOT NULL,*

*EmailAddr varchar(200) NOT NULL,*

*PubYMD char(8) NOT NULL,*

*UseYMD char(8) DEFAULT NULL,*

*UseStateCode tinyint(4) NOT NULL,*

*RegDate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,*

*UpdDate datetime DEFAULT NULL,*

*PRIMARY KEY (CouponID),*

*UNIQUE KEY SeqNo_UNIQUE (CouponID),*

*UNIQUE KEY CouponNo_UNIQUE (CouponNo),*

*UNIQUE KEY EmailAddr_UNIQUE (EmailAddr),*

*KEY PubYMD (PubYMD),*

*KEY EmailAddr (EmailAddr)*

*) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='쿠폰 마스터 테이블';*

### 5. 테스트 케이스

| 쿠폰 데모 테스트                                             |
| ------------------------------------------------------------ |
| 1. 쿠폰 리스트는 정상적으로 출력되는가?                      |
| 2. 쿠폰 리스트의  페이징은 정상적으로 작동 되는가?           |
| 3. 쿠폰 리스트는 컬럼에  맞는 데이터가 출력되는가?           |
| 4. 이메일 빈값 입력 시  유효성 체크가 정상적으로 작동되는가? |
| 5. 쿠폰생성 시 이메일  형식 유효성 체크가 정상적으로 작동되는가? |
| 6. 쿠폰생성 시 이메일  중복체크는 정상적으로 작동되는가?     |
| 7. 쿠폰생성 시 쿠폰번호  중복체크는 정상적으로 작동되는가?   |
| 8. 쿠폰은 정상적으로  생성되는가?                            |
| 9. 생성된 쿠폰은  16자리 정규식[0-9a-zA-Z]을 만족하는가?     |
| 10. 생성된 쿠폰은  리스트에 정상적으로 노출되는가?           |

### 6. 느낀점

- 처음 사용하는 자바 스프링 부트이기에 초기 구성 및 시작하는데 많은 고난이 있었습니다. 과연 단기간에 만들 수 있을까라는 생각도 했지만 포기하지 않고 끝까지 해보겠다는 도전정신으로 프로젝트를 완성할 수 있었습니다.


# 감사합니다!

*비동기 리스트 페이징 추가구현 완료

*ajax callback 함수로 구현 변경하기
