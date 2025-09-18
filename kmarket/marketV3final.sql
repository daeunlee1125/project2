-- 기존 테이블 삭제
DROP TABLE cust_addr CASCADE CONSTRAINTS;
DROP TABLE cust_seller_info CASCADE CONSTRAINTS;
DROP TABLE cust_seller_rating CASCADE CONSTRAINTS;
DROP TABLE sys_point_history CASCADE CONSTRAINTS;
DROP TABLE cust_user_coupon CASCADE CONSTRAINTS;
DROP TABLE cs_review CASCADE CONSTRAINTS;
DROP TABLE ord_order_item CASCADE CONSTRAINTS;
DROP TABLE ord_order CASCADE CONSTRAINTS;
DROP TABLE prod_option CASCADE CONSTRAINTS;
DROP TABLE prod_notice CASCADE CONSTRAINTS;
DROP TABLE prod_product CASCADE CONSTRAINTS;
DROP TABLE prod_category2 CASCADE CONSTRAINTS;
DROP TABLE prod_category1 CASCADE CONSTRAINTS;
DROP TABLE sys_story CASCADE CONSTRAINTS;
DROP TABLE sys_media CASCADE CONSTRAINTS;
DROP TABLE sys_recruit CASCADE CONSTRAINTS;
DROP TABLE sys_banner CASCADE CONSTRAINTS;
DROP TABLE sys_version CASCADE CONSTRAINTS;
DROP TABLE sys_config CASCADE CONSTRAINTS;
DROP TABLE sys_admin CASCADE CONSTRAINTS;
DROP TABLE cust_member CASCADE CONSTRAINTS;
DROP TABLE ord_return_exchange CASCADE CONSTRAINTS;
DROP TABLE cust_cart CASCADE CONSTRAINTS;
DROP TABLE sys_coupon_master CASCADE CONSTRAINTS; -- 쿠폰 마스터 테이블 추가

-- 1. 회원 및 판매자 관련 테이블
CREATE TABLE cust_member (
  cust_uid VARCHAR2(20) PRIMARY KEY,
  cust_pass VARCHAR2(255) NOT NULL,
  cust_name VARCHAR2(20) NOT NULL,
  cust_gender NUMBER(1),
  cust_hp VARCHAR2(13),
  cust_email VARCHAR2(50),
  cust_level NUMBER(1) NOT NULL,
  cust_status VARCHAR2(10) NOT NULL,
  cust_point NUMBER(10) DEFAULT 0,
  cust_joinDate DATE NOT NULL,
  cust_lastLogin DATE
);
COMMENT ON TABLE cust_member IS '회원 정보';
COMMENT ON COLUMN cust_member.cust_uid IS '회원 아이디';
COMMENT ON COLUMN cust_member.cust_pass IS '비밀번호 (암호화)';
COMMENT ON COLUMN cust_member.cust_name IS '이름';
COMMENT ON COLUMN cust_member.cust_gender IS '성별 (1:남, 2:여)';
COMMENT ON COLUMN cust_member.cust_hp IS '휴대폰 번호';
COMMENT ON COLUMN cust_member.cust_email IS '이메일';
COMMENT ON COLUMN cust_member.cust_level IS '등급 (1:일반, 2:판매자, 9:관리자)';
COMMENT ON COLUMN cust_member.cust_status IS '회원 상태 (정상, 정지, 휴면, 탈퇴)';
COMMENT ON COLUMN cust_member.cust_point IS '포인트';
COMMENT ON COLUMN cust_member.cust_joinDate IS '가입일';
COMMENT ON COLUMN cust_member.cust_lastLogin IS '최근 로그인 날짜';

-- 판매자 추가 정보 테이블
CREATE TABLE cust_seller_info (
  cust_uid VARCHAR2(20) PRIMARY KEY,
  cust_company VARCHAR2(50) NOT NULL,
  cust_corp_reg_no CHAR(12) NOT NULL,
  cust_tel_reg_no CHAR(12) NOT NULL,
  cust_tel VARCHAR2(13),
  cust_fax VARCHAR2(13),
  cust_email VARCHAR2(50),
  FOREIGN KEY (cust_uid) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE cust_seller_info IS '판매자 추가 정보';
COMMENT ON COLUMN cust_seller_info.cust_uid IS '판매자 아이디';
COMMENT ON COLUMN cust_seller_info.cust_company IS '회사명';
COMMENT ON COLUMN cust_seller_info.cust_corp_reg_no IS '사업자등록번호';
COMMENT ON COLUMN cust_seller_info.cust_tel_reg_no IS '통신판매업신고번호';
COMMENT ON COLUMN cust_seller_info.cust_tel IS '회사 전화번호';
COMMENT ON COLUMN cust_seller_info.cust_fax IS '팩스 번호';
COMMENT ON COLUMN cust_seller_info.cust_email IS '판매자 이메일';

-- 회원 주소 테이블
CREATE TABLE cust_addr (
  cust_addrNo NUMBER(10) PRIMARY KEY,
  cust_uid VARCHAR2(20) NOT NULL,
  cust_zip CHAR(5),
  cust_addr1 VARCHAR2(255),
  cust_addr2 VARCHAR2(255),
  FOREIGN KEY (cust_uid) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE cust_addr IS '회원 주소록';
COMMENT ON COLUMN cust_addr.cust_addrNo IS '주소 번호';
COMMENT ON COLUMN cust_addr.cust_uid IS '회원 아이디';
COMMENT ON COLUMN cust_addr.cust_zip IS '우편번호';
COMMENT ON COLUMN cust_addr.cust_addr1 IS '기본 주소';
COMMENT ON COLUMN cust_addr.cust_addr2 IS '상세 주소';

-- 판매자 평가 테이블
CREATE TABLE cust_seller_rating (
  cust_seller_ratingNo NUMBER(10) PRIMARY KEY,
  cust_uid VARCHAR2(20) NOT NULL,
  cust_rating NUMBER(1) NOT NULL,
  cust_rating_rdate DATE NOT NULL,
  FOREIGN KEY (cust_uid) REFERENCES cust_member(cust_uid)
);
COMMENT ON TABLE cust_seller_rating IS '판매자 고객 만족도 평가';
COMMENT ON COLUMN cust_seller_rating.cust_seller_ratingNo IS '평가 번호';
COMMENT ON COLUMN cust_seller_rating.cust_uid IS '판매자 아이디';
COMMENT ON COLUMN cust_seller_rating.cust_rating IS '평가 점수 (1~5)';
COMMENT ON COLUMN cust_seller_rating.cust_rating_rdate IS '평가 날짜';


-- 장바구니
CREATE TABLE cust_cart (
  cart_no NUMBER(10) PRIMARY KEY,
  cust_uid VARCHAR2(20) NOT NULL,
  prod_prodNo NUMBER(10) NOT NULL,
  cart_count NUMBER(10) NOT NULL,
  cart_rdate DATE NOT NULL,
  FOREIGN KEY (cust_uid) REFERENCES cust_member(cust_uid),
  FOREIGN KEY (prod_prodNo) REFERENCES prod_product(prod_prodNo)
);
COMMENT ON TABLE cust_cart IS '장바구니';
COMMENT ON COLUMN cust_cart.cart_no IS '장바구니 번호';
COMMENT ON COLUMN cust_cart.cust_uid IS '회원 아이디';
COMMENT ON COLUMN cust_cart.prod_prodNo IS '상품 번호';
COMMENT ON COLUMN cust_cart.cart_count IS '수량';
COMMENT ON COLUMN cust_cart.cart_rdate IS '담은 날짜';


-- 2. 상품 관련 테이블
CREATE TABLE prod_category1 (
  prod_cate1No NUMBER(10) PRIMARY KEY,
  prod_cate1Name VARCHAR2(50) NOT NULL
);
COMMENT ON TABLE prod_category1 IS '1차 상품 카테고리';
COMMENT ON COLUMN prod_category1.prod_cate1No IS '1차 카테고리 번호';
COMMENT ON COLUMN prod_category1.prod_cate1Name IS '1차 카테고리명';


CREATE TABLE prod_category2 (
  prod_cate2No NUMBER(10) PRIMARY KEY,
  prod_cate1No NUMBER(10) NOT NULL,
  prod_cate2Name VARCHAR2(50) NOT NULL,
  FOREIGN KEY (prod_cate1No) REFERENCES prod_category1(prod_cate1No)
);
COMMENT ON TABLE prod_category2 IS '2차 상품 카테고리';
COMMENT ON COLUMN prod_category2.prod_cate2No IS '2차 카테고리 번호';
COMMENT ON COLUMN prod_category2.prod_cate1No IS '1차 카테고리 번호';
COMMENT ON COLUMN prod_category2.prod_cate2Name IS '2차 카테고리명';


CREATE TABLE prod_product (
  prod_prodNo NUMBER(10) PRIMARY KEY,
  prod_cate1 NUMBER(10) NOT NULL,
  prod_cate2 NUMBER(10) NOT NULL,
  prod_prodName VARCHAR2(255) NOT NULL,
  prod_descript CLOB,
  prod_company VARCHAR2(255),
  prod_seller VARCHAR2(20) NOT NULL,
  prod_price NUMBER(10) NOT NULL,
  prod_discount NUMBER(3) DEFAULT 0,
  prod_delivery NUMBER(10) DEFAULT 0,
  prod_point NUMBER(10) DEFAULT 0,
  prod_stock NUMBER(10) DEFAULT 0,
  prod_thumb1 VARCHAR2(255),
  prod_detailImg VARCHAR2(255),
  prod_sold NUMBER(10) DEFAULT 0,
  prod_hit NUMBER(10) DEFAULT 0,
  prod_rdate DATE NOT NULL,
  FOREIGN KEY (prod_cate1) REFERENCES prod_category1(prod_cate1No),
  FOREIGN KEY (prod_cate2) REFERENCES prod_category2(prod_cate2No),
  FOREIGN KEY (prod_seller) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE prod_product IS '상품 정보';
COMMENT ON COLUMN prod_product.prod_prodNo IS '상품 번호';
COMMENT ON COLUMN prod_product.prod_cate1 IS '1차 카테고리';
COMMENT ON COLUMN prod_product.prod_cate2 IS '2차 카테고리';
COMMENT ON COLUMN prod_product.prod_prodName IS '상품명';
COMMENT ON COLUMN prod_product.prod_descript IS '상품 상세 설명';
COMMENT ON COLUMN prod_product.prod_company IS '제조사';
COMMENT ON COLUMN prod_product.prod_seller IS '판매자 아이디';
COMMENT ON COLUMN prod_product.prod_price IS '판매 가격';
COMMENT ON COLUMN prod_product.prod_discount IS '할인율 (%)';
COMMENT ON COLUMN prod_product.prod_delivery IS '배송비';
COMMENT ON COLUMN prod_product.prod_point IS '적립 포인트';
COMMENT ON COLUMN prod_product.prod_stock IS '재고 수량';
COMMENT ON COLUMN prod_product.prod_thumb1 IS '썸네일 이미지 파일 경로';
COMMENT ON COLUMN prod_product.prod_detailImg IS '상세 이미지 파일 경로';
ON COLUMN prod_product.prod_sold IS '판매 수량';
COMMENT ON COLUMN prod_product.prod_hit IS '조회수';
COMMENT ON COLUMN prod_product.prod_rdate IS '등록일';


CREATE TABLE prod_option (
  prod_optionNo NUMBER(10) PRIMARY KEY,
  prod_prodNo NUMBER(10) NOT NULL,
  prod_optionName VARCHAR2(50) NOT NULL,
  prod_optionValue VARCHAR2(255) NOT NULL,
  FOREIGN KEY (prod_prodNo) REFERENCES prod_product(prod_prodNo)
);
COMMENT ON TABLE prod_option IS '상품 옵션';
COMMENT ON COLUMN prod_option.prod_optionNo IS '옵션 번호';
COMMENT ON COLUMN prod_option.prod_prodNo IS '상품 번호';
COMMENT ON COLUMN prod_option.prod_optionName IS '옵션명 (예: 사이즈, 색상)';
COMMENT ON COLUMN prod_option.prod_optionValue IS '옵션값 (예: XL, 빨간색)';


CREATE TABLE prod_notice (
  prod_noticeNo NUMBER(10) PRIMARY KEY,
  prod_prodNo NUMBER(10) NOT NULL,
  prod_noticeType VARCHAR2(50) NOT NULL,
  prod_noticeValue VARCHAR2(255) NOT NULL,
  FOREIGN KEY (prod_prodNo) REFERENCES prod_product(prod_prodNo)
);
COMMENT ON TABLE prod_notice IS '상품 정보 고시';
COMMENT ON COLUMN prod_notice.prod_noticeNo IS '고시 번호';
COMMENT ON COLUMN prod_notice.prod_prodNo IS '상품 번호';
COMMENT ON COLUMN prod_notice.prod_noticeType IS '고시 정보 타입 (예: 상품상태, 부가세면세여부)';
COMMENT ON COLUMN prod_notice.prod_noticeValue IS '고시 정보 값 (예: 신상품, 과세상품)';


-- 3. 주문/결제 관련 테이블
CREATE TABLE ord_order (
  ord_ordNo NUMBER(10) PRIMARY KEY,
  ord_ordUid VARCHAR2(20) NOT NULL,
  ord_ordName VARCHAR2(20) NOT NULL,
  ord_ordHp VARCHAR2(13) NOT NULL,
  ord_ordZip CHAR(5) NOT NULL,
  ord_ordAddr1 VARCHAR2(255) NOT NULL,
  ord_ordAddr2 VARCHAR2(255) NOT NULL,
  ord_ordTotal NUMBER(10) NOT NULL,
  ord_ordDate DATE NOT NULL,
  ord_paymentMethod VARCHAR2(20) NOT NULL,
  FOREIGN KEY (ord_ordUid) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE ord_order IS '주문 정보';
COMMENT ON COLUMN ord_order.ord_ordNo IS '주문 번호';
COMMENT ON COLUMN ord_order.ord_ordUid IS '주문자 아이디';
COMMENT ON COLUMN ord_order.ord_ordName IS '수령인';
COMMENT ON COLUMN ord_order.ord_ordHp IS '수령인 연락처';
COMMENT ON COLUMN ord_order.ord_ordZip IS '수령인 우편번호';
COMMENT ON COLUMN ord_order.ord_ordAddr1 IS '수령인 기본 주소';
COMMENT ON COLUMN ord_order.ord_ordAddr2 IS '수령인 상세 주소';
COMMENT ON COLUMN ord_order.ord_ordTotal IS '총 결제 금액';
COMMENT ON COLUMN ord_order.ord_ordDate IS '주문일시';
COMMENT ON COLUMN ord_order.ord_paymentMethod IS '결제 방법';


-- 주문 상품 정보 테이블
CREATE TABLE ord_order_item (
  ord_ordItemNo NUMBER(10) PRIMARY KEY,
  ord_ordNo NUMBER(10) NOT NULL,
  ord_prodNo NUMBER(10) NOT NULL,
  ord_prodName VARCHAR2(255) NOT NULL,
  ord_count NUMBER(10) NOT NULL,
  ord_price NUMBER(10) NOT NULL,
  ord_total NUMBER(10) NOT NULL,
  FOREIGN KEY (ord_ordNo) REFERENCES ord_order (ord_ordNo),
  FOREIGN KEY (ord_prodNo) REFERENCES prod_product (prod_prodNo)
);
COMMENT ON TABLE ord_order_item IS '주문 상품 정보';
COMMENT ON COLUMN ord_order_item.ord_ordItemNo IS '주문 상품 번호';
COMMENT ON COLUMN ord_order_item.ord_ordNo IS '주문 번호';
COMMENT ON COLUMN ord_order_item.ord_prodNo IS '상품 번호';
COMMENT ON COLUMN ord_order_item.ord_prodName IS '상품명';
COMMENT ON COLUMN ord_order_item.ord_count IS '주문 수량';
COMMENT ON COLUMN ord_order_item.ord_price IS '개별 상품 가격';
COMMENT ON COLUMN ord_order_item.ord_total IS '상품별 총액';


-- 반품/교환 정보
CREATE TABLE ord_return_exchange (
  ord_returnNo NUMBER(10) PRIMARY KEY,
  ord_ordNo NUMBER(10) NOT NULL,
  ord_prodNo NUMBER(10) NOT NULL,
  ord_returnType VARCHAR2(20) NOT NULL,
  ord_returnReason VARCHAR2(255) NOT NULL,
  ord_return_rdate DATE NOT NULL,
  FOREIGN KEY (ord_ordNo) REFERENCES ord_order(ord_ordNo),
  FOREIGN KEY (ord_prodNo) REFERENCES prod_product(prod_prodNo)
);
COMMENT ON TABLE ord_return_exchange IS '반품/교환 정보';
COMMENT ON COLUMN ord_return_exchange.ord_returnNo IS '반품/교환 번호';
COMMENT ON COLUMN ord_return_exchange.ord_ordNo IS '주문 번호';
COMMENT ON COLUMN ord_return_exchange.ord_prodNo IS '상품 번호';
COMMENT ON COLUMN ord_return_exchange.ord_returnType IS '반품/교환 유형';
COMMENT ON COLUMN ord_return_exchange.ord_returnReason IS '반품/교환 사유';
COMMENT ON COLUMN ord_return_exchange.ord_return_rdate IS '신청 날짜';


-- 주문 카트 (장바구니와 별개)
CREATE TABLE ord_cart (
  ord_cartNo NUMBER(10) PRIMARY KEY,
  ord_ordNo NUMBER(10) NOT NULL,
  prod_prodNo NUMBER(10) NOT NULL,
  ord_count NUMBER(10) NOT NULL,
  FOREIGN KEY (ord_ordNo) REFERENCES ord_order(ord_ordNo),
  FOREIGN KEY (prod_prodNo) REFERENCES prod_product(prod_prodNo)
);
COMMENT ON TABLE ord_cart IS '주문 준비 카트';
COMMENT ON COLUMN ord_cart.ord_cartNo IS '카트 번호';
COMMENT ON COLUMN ord_cart.ord_ordNo IS '주문 번호';
COMMENT ON COLUMN ord_cart.prod_prodNo IS '상품 번호';
COMMENT ON COLUMN ord_cart.ord_count IS '수량';

--------고객센터 관련 테이블
-- 기존 테이블 삭제
DROP TABLE cs_review CASCADE CONSTRAINTS;
DROP TABLE cs_faq CASCADE CONSTRAINTS;
DROP TABLE cs_qna CASCADE CONSTRAINTS;
DROP TABLE cs_notice CASCADE CONSTRAINTS;

-- 공지사항
CREATE TABLE cs_notice (
  cs_no NUMBER(10) PRIMARY KEY,
  cs_type VARCHAR2(20),
  cs_title VARCHAR2(255) NOT NULL,
  cs_content CLOB NOT NULL,
  cs_rdate DATE NOT NULL
);
COMMENT ON TABLE cs_notice IS '공지사항';
COMMENT ON COLUMN cs_notice.cs_no IS '글 번호';
COMMENT ON COLUMN cs_notice.cs_type IS '유형';
COMMENT ON COLUMN cs_notice.cs_title IS '제목';
COMMENT ON COLUMN cs_notice.cs_content IS '내용';
COMMENT ON COLUMN cs_notice.cs_rdate IS '작성일';


-- 고객 문의
CREATE TABLE cs_qna (
  cs_qnaNo NUMBER(10) PRIMARY KEY,
  cs_qnaCate VARCHAR2(20),
  cs_title VARCHAR2(255) NOT NULL,
  cs_content CLOB NOT NULL,
  cs_writer VARCHAR2(20) NOT NULL,
  cs_rdate DATE NOT NULL,
  cs_reply CLOB,
  cs_replyDate DATE,
  FOREIGN KEY (cs_writer) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE cs_qna IS '고객 문의';
COMMENT ON COLUMN cs_qna.cs_qnaNo IS '문의 글 번호';
COMMENT ON COLUMN cs_qna.cs_qnaCate IS '문의 유형';
COMMENT ON COLUMN cs_qna.cs_title IS '제목';
COMMENT ON COLUMN cs_qna.cs_content IS '내용';
COMMENT ON COLUMN cs_qna.cs_writer IS '작성자 아이디';
COMMENT ON COLUMN cs_qna.cs_rdate IS '작성일';
COMMENT ON COLUMN cs_qna.cs_reply IS '답변 내용';
COMMENT ON COLUMN cs_qna.cs_replyDate IS '답변일';


-- 자주 묻는 질문
CREATE TABLE cs_faq (
  cs_faqNo NUMBER(10) PRIMARY KEY,
  cs_faqCate1 VARCHAR2(20) NOT NULL,
  cs_faqCate2 VARCHAR2(20),
  cs_title VARCHAR2(255) NOT NULL,
  cs_content CLOB NOT NULL
);
COMMENT ON TABLE cs_faq IS '자주 묻는 질문';
COMMENT ON COLUMN cs_faq.cs_faqNo IS '자주묻는질문 번호';
COMMENT ON COLUMN cs_faq.cs_faqCate1 IS '1차 유형';
COMMENT ON COLUMN cs_faq.cs_faqCate2 IS '2차 유형';
COMMENT ON COLUMN cs_faq.cs_title IS '제목';
COMMENT ON COLUMN cs_faq.cs_content IS '내용';


-- 상품 리뷰
CREATE TABLE cs_review (
  cs_revNo NUMBER(10) PRIMARY KEY,
  cs_prodNo NUMBER(10) NOT NULL,
  cs_uid VARCHAR2(20) NOT NULL,
  cs_content CLOB NOT NULL,
  cs_rating NUMBER(1) NOT NULL,
  cs_rdate DATE NOT NULL,
  FOREIGN KEY (cs_prodNo) REFERENCES prod_product (prod_prodNo),
  FOREIGN KEY (cs_uid) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE cs_review IS '상품 리뷰';
COMMENT ON COLUMN cs_review.cs_revNo IS '리뷰 번호';
COMMENT ON COLUMN cs_review.cs_prodNo IS '상품 번호';
COMMENT ON COLUMN cs_review.cs_uid IS '작성자 아이디';
COMMENT ON COLUMN cs_review.cs_content IS '내용';
COMMENT ON COLUMN cs_review.cs_rating IS '평점';
COMMENT ON COLUMN cs_review.cs_rdate IS '작성일';

--------관리자 및 시스템 관련 테이블
-- 기존 테이블 삭제
DROP TABLE sys_story CASCADE CONSTRAINTS;
DROP TABLE sys_media CASCADE CONSTRAINTS;
DROP TABLE sys_recruit CASCADE CONSTRAINTS;
DROP TABLE sys_banner CASCADE CONSTRAINTS;
DROP TABLE sys_version CASCADE CONSTRAINTS;
DROP TABLE sys_config CASCADE CONSTRAINTS;
DROP TABLE sys_admin CASCADE CONSTRAINTS;
DROP TABLE sys_user_coupon CASCADE CONSTRAINTS;
DROP TABLE sys_point_history CASCADE CONSTRAINTS;
DROP TABLE sys_file CASCADE CONSTRAINTS;

-- 관리자
CREATE TABLE sys_admin (
  sys_admin_uid VARCHAR2(20) PRIMARY KEY,
  sys_admin_pass VARCHAR2(255) NOT NULL,
  sys_admin_level NUMBER(1) NOT NULL,
  sys_admin_rdate DATE NOT NULL
);
COMMENT ON TABLE sys_admin IS '관리자 정보';
COMMENT ON COLUMN sys_admin.sys_admin_uid IS '관리자 아이디';
COMMENT ON COLUMN sys_admin.sys_admin_pass IS '비밀번호';
COMMENT ON COLUMN sys_admin.sys_admin_level IS '관리자 등급';
COMMENT ON COLUMN sys_admin.sys_admin_rdate IS '등록일';


-- 배너 정보
CREATE TABLE sys_banner (
  sys_bannerNo NUMBER(10) PRIMARY KEY,
  sys_bannerName VARCHAR2(50),
  sys_bannerSize VARCHAR2(20),
  sys_bgColor VARCHAR2(10),
  sys_location VARCHAR2(50) NOT NULL,
  sys_imagePath VARCHAR2(255) NOT NULL,
  sys_bannerLink VARCHAR2(255),
  sys_startDate DATE,
  sys_endDate DATE,
  sys_status NUMBER(1) DEFAULT 1
);
COMMENT ON TABLE sys_banner IS '배너 정보';
COMMENT ON COLUMN sys_banner.sys_bannerNo IS '배너 번호';
COMMENT ON COLUMN sys_banner.sys_bannerName IS '배너 이름';
COMMENT ON COLUMN sys_banner.sys_bannerSize IS '배너 크기';
COMMENT ON COLUMN sys_banner.sys_bgColor IS '배경색';
COMMENT ON COLUMN sys_banner.sys_location IS '노출 위치';
COMMENT ON COLUMN sys_banner.sys_imagePath IS '이미지 파일 경로';
COMMENT ON COLUMN sys_banner.sys_bannerLink IS '링크 주소';
COMMENT ON COLUMN sys_banner.sys_startDate IS '노출 시작일';
COMMENT ON COLUMN sys_banner.sys_endDate IS '노출 종료일';
COMMENT ON COLUMN sys_banner.sys_status IS '노출 상태 (1: 활성, 0: 비활성)';


-- 포인트 내역
CREATE TABLE sys_point_history (
  sys_histNo NUMBER(10) PRIMARY KEY,
  sys_uid VARCHAR2(20) NOT NULL,
  sys_type NUMBER(1) NOT NULL,
  sys_point NUMBER(10) NOT NULL,
  sys_description VARCHAR2(255),
  sys_rdate DATE NOT NULL,
  FOREIGN KEY (sys_uid) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE sys_point_history IS '포인트 내역';
COMMENT ON COLUMN sys_point_history.sys_histNo IS '내역 번호';
COMMENT ON COLUMN sys_point_history.sys_uid IS '회원 아이디';
COMMENT ON COLUMN sys_point_history.sys_type IS '구분 (1:적립, 2:사용)';
COMMENT ON COLUMN sys_point_history.sys_point IS '포인트 변동량';
COMMENT ON COLUMN sys_point_history.sys_description IS '내역 설명';
COMMENT ON COLUMN sys_point_history.sys_rdate IS '발생일';


-- 사용자별 쿠폰 정보
CREATE TABLE sys_user_coupon (
  sys_couponId NUMBER(10) PRIMARY KEY,
  sys_uid VARCHAR2(20) NOT NULL,
  sys_type VARCHAR2(50) NOT NULL,
  sys_discount VARCHAR2(50) NOT NULL,
  sys_usedDate DATE,
  sys_expiryDate DATE NOT NULL,
  FOREIGN KEY (sys_uid) REFERENCES cust_member (cust_uid)
);
COMMENT ON TABLE sys_user_coupon IS '사용자별 쿠폰 정보';
COMMENT ON COLUMN sys_user_coupon.sys_couponId IS '쿠폰 번호';
COMMENT ON COLUMN sys_user_coupon.sys_uid IS '회원 아이디';
COMMENT ON COLUMN sys_user_coupon.sys_type IS '쿠폰 유형';
COMMENT ON COLUMN sys_user_coupon.sys_discount IS '할인 내용';
COMMENT ON COLUMN sys_user_coupon.sys_usedDate IS '사용일';
COMMENT ON COLUMN sys_user_coupon.sys_expiryDate IS '유효기간';


-- 사이트 환경설정
CREATE TABLE sys_config (
  sys_configNo NUMBER(10) PRIMARY KEY,
  sys_siteName VARCHAR2(50) NOT NULL,
  sys_companyName VARCHAR2(50) NOT NULL,
  sys_ceoName VARCHAR2(20) NOT NULL,
  sys_logo_path VARCHAR2(255)
);
COMMENT ON TABLE sys_config IS '사이트 환경설정';
COMMENT ON COLUMN sys_config.sys_configNo IS '설정 번호';
COMMENT ON COLUMN sys_config.sys_siteName IS '사이트 이름';
COMMENT ON COLUMN sys_config.sys_companyName IS '회사 상호';
COMMENT ON COLUMN sys_config.sys_ceoName IS '대표자';
COMMENT ON COLUMN sys_config.sys_logo_path IS '로고 이미지 경로';


-- 채용 공고
CREATE TABLE sys_recruit (
  sys_recruitNo NUMBER(10) PRIMARY KEY,
  sys_title VARCHAR2(255) NOT NULL,
  sys_department VARCHAR2(50) NOT NULL,
  sys_experience VARCHAR2(50) NOT NULL,
  sys_job_type VARCHAR2(50) NOT NULL,
  sys_end_date DATE NOT NULL,
  sys_rdate DATE NOT NULL
);
COMMENT ON TABLE sys_recruit IS '채용 공고';
COMMENT ON COLUMN sys_recruit.sys_recruitNo IS '채용 공고 번호';
COMMENT ON COLUMN sys_recruit.sys_title IS '제목';
COMMENT ON COLUMN sys_recruit.sys_department IS '채용 부서';
COMMENT ON COLUMN sys_recruit.sys_experience IS '경력';
COMMENT ON COLUMN sys_recruit.sys_job_type IS '채용 형태';
COMMENT ON COLUMN sys_recruit.sys_end_date IS '모집 마감일';
COMMENT ON COLUMN sys_recruit.sys_rdate IS '등록일';


-- 버전 관리
CREATE TABLE sys_version (
  sys_versionNo NUMBER(10) PRIMARY KEY,
  sys_version VARCHAR2(20) NOT NULL,
  sys_description VARCHAR2(255),
  sys_writer VARCHAR2(20) NOT NULL,
  sys_rdate DATE NOT NULL
);
COMMENT ON TABLE sys_version IS '버전 관리';
COMMENT ON COLUMN sys_version.sys_versionNo IS '버전 번호';
COMMENT ON COLUMN sys_version.sys_version IS '버전';
COMMENT ON COLUMN sys_version.sys_description IS '변경 내용';
COMMENT ON COLUMN sys_version.sys_writer IS '작성자';
COMMENT ON COLUMN sys_version.sys_rdate IS '등록일';


-- 회사 소식 및 이야기
CREATE TABLE sys_story (
  sys_storyNo NUMBER(10) PRIMARY KEY,
  sys_title VARCHAR2(255) NOT NULL,
  sys_content CLOB NOT NULL,
  sys_rdate DATE NOT NULL
);
COMMENT ON TABLE sys_story IS '회사 소식 및 이야기';
COMMENT ON COLUMN sys_story.sys_storyNo IS '이야기 번호';
COMMENT ON COLUMN sys_story.sys_title IS '제목';
COMMENT ON COLUMN sys_story.sys_content IS '내용';
COMMENT ON COLUMN sys_story.sys_rdate IS '등록일';


-- 미디어 정보
CREATE TABLE sys_media (
  sys_mediaNo NUMBER(10) PRIMARY KEY,
  sys_title VARCHAR2(255) NOT NULL,
  sys_videoLink VARCHAR2(255) NOT NULL,
  sys_rdate DATE NOT NULL
);
COMMENT ON TABLE sys_media IS '미디어 정보';
COMMENT ON COLUMN sys_media.sys_mediaNo IS '미디어 번호';
COMMENT ON COLUMN sys_media.sys_title IS '제목';
COMMENT ON COLUMN sys_media.sys_videoLink IS '유튜브 링크';
COMMENT ON COLUMN sys_media.sys_rdate IS '등록일';


-- 파일 업로드 정보
CREATE TABLE sys_file (
  file_no NUMBER(10) PRIMARY KEY,
  file_parent_table VARCHAR2(50) NOT NULL,
  file_parent_no NUMBER(10) NOT NULL,
  file_path VARCHAR2(255) NOT NULL,
  file_name VARCHAR2(255) NOT NULL,
  file_rdate DATE NOT NULL
);

COMMENT ON TABLE sys_file IS '파일 업로드 정보';
COMMENT ON COLUMN sys_file.file_no IS '파일 번호';
COMMENT ON COLUMN sys_file.file_parent