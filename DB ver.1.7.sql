-- SPORTSLIGHT 테이블 ver.1.3

/*
목차
1. 초기화
2. 테이블, 시퀸스생성
3. 외래키 생성
*/

-- 초기화
drop table videoBoard;
drop table video;
drop table league;
drop table season;
drop table team;
drop table matchSchedule;
drop table matchResult;
drop table heart;
drop table favorite;
drop table memberz;
drop table memberFavor;
drop table betting;
drop table bettingRecord;
drop table adminz;
drop table notice;
drop table footballTalk;
drop table footballTalkReply;

drop SEQUENCE FAVORITESEQ;
drop SEQUENCE HEARTSEQ;
drop SEQUENCE LEAGUESEQ;
drop SEQUENCE MATCHRESULTSEQ;
drop SEQUENCE MATCHSCHEDULESEQ;
drop SEQUENCE SEASONSEQ;
drop SEQUENCE TEAMSEQ;
drop SEQUENCE VIDEOBOARDSEQ;
drop SEQUENCE VIDEOSEQ;
drop SEQUENCE adminzSEQ;
drop SEQUENCE bettingSEQ;
drop SEQUENCE memberFavorSEQ;
drop SEQUENCE memberzSEQ;
drop SEQUENCE noticeSEQ;
drop SEQUENCE footballTalkSEQ;
drop SEQUENCE footballTalkReplySEQ;
drop SEQUENCE bettingRecordSEQ;


commit;

-- 회원정보 테이블 생성
CREATE TABLE memberz
(memberNum number not null CONSTRAINT memberNum primary key,
memberEmail varchar2(300) not null,
memberPass varchar2(300) not null,
memberProfile varchar2(100) not null,
memberReg date not null,
memberLocked char(1) not null,
memberLeave char(1) not null
);

-- 회원정보 시퀸스 생성
create SEQUENCE memberzSEQ
INCREMENT by 1
start WITH 1
nocache
nocycle;

-- 회원선호 테이블 생성
create table memberFavor
(favorNum number not null CONSTRAINT favorNum primary key,
memberNum number not null,
teamNum1 number,
teamNum2 number,
teamNum3 number,
leagueNum1 number,
leagueNum2 number,
leagueNum3 number
);

-- 회원선호 시퀸스 생성
create SEQUENCE memberFavorSEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

-- 관리자 정보 테이블 생성
create table adminz(
adminNum number not null CONSTRAINT adminNum PRIMARY KEY,
adminEmail varchar2(100) not null,
adminPass varchar2(100) not null,
admainProfile varchar2(100) not null
);

-- 관리자 정보 시퀀스 생성
create SEQUENCE adminzSEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

-- 공지사항 테이블 생성
create table notice(
noticeNum number not null CONSTRAINT noticeNum PRIMARY KEY,
adminNum number not null,
noticeTitle varchar2(300) not null,
noticeContent varchar2(3000) not null,
writeDate date not null
);

-- 공지사항 시퀸스 생성
create SEQUENCE noticeSEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

-- 축구토크 게시판 테이블 생성
create table footballTalk(
talkNum number not null CONSTRAINT talkNum PRIMARY KEY,
memberNum number not null,
leagueNum number not null,
talkTitle varchar2(300) not null,
talkContent varchar2(3000) not null,
talkUpload varchar2(3000) not null,
regDate date not null,
talkViews number default 0
);

-- 공지사항 시퀸스 생성
create SEQUENCE footballTalkSEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

-- 축구토크 댓글 게시판 테이블 생성
create table footballTalkReply(
talkReplyNum number not null CONSTRAINT talkReplyNum PRIMARY KEY,
talkNum number not null,
memberNum number not null,
talkReplyContent varchar2(300) not null,
regDate date not null
);

-- 축구토크 댓글 시퀸스 생성
create SEQUENCE footballTalkReplySEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;


-- 좋아요 게시판 생성
create table heart (
    likeNum number constraint likeNum primary key, -- 좋아요 고유번호
    memberNum number, -- 외래키
    videoNum number -- 외래키
);


-- 좋아요 테이블 시퀀스 생성
create sequence heartSeq
start with 1
increment by 1
nocache
nocycle;

-- 임의 데이터 삽입
INSERT INTO heart
VALUES(heartSeq.nextval,1,1);


-- 데이터 확인
select * from heart;
------------------------------------------------------------
-- 즐겨찾기 테이블/ 시퀀스 삭제
drop table favorite;
drop sequence favoriteSeq;

-- 즐겨찾기 테이블 생성
create table favorite (
    favoriteNum number constraint favoriteNum primary key, -- 즐겨찾기 고유번호
    memberNum number, -- 외래키
    videoNum number -- 외래키
);

-- 즐겨찾기 시퀀스 생성
create sequence favoriteSeq
start with 1
increment by 1
nocache
nocycle;

-- 임의 데이터 삽입
INSERT INTO favorite
VALUES(favoriteSeq.nextval,1,1);


-- 즐겨찾기 테이블 확인
select * from favorite;
------------------------------------------------------------
-- 동영상 테이블 / 시퀀스 삭제
drop table video;
drop sequence videoSeq;

-- 동영상 테이블 생성
create table video(
videoNum number constraint videoNum primary key, -- 동영상 고유번호
videoName varchar2(200) not null,
thumbnailUrl varchar2(400) not null,
videoUrl varchar2(400) not null,
videoViews number default 0 not null, -- 디폴트 0
videotype char(1) not null,
teamNum1 number, -- 외래키
teamNum2 number, -- 외래키
leagueNum number, -- 외래키
seasonNum number -- 외래키
);

-- 동영상 테이블 시퀀스 생성
create sequence videoSeq
start with 4798
increment by 1
nocache
nocycle;

-- 동영상 테이블 확인
select * from video;
------------------------------------------------------------
-- 동영상 한 줄 게시판 / 시퀀스 삭제
drop table videoBoard;
drop sequence videoBoardSeq;

-- 동영상 한 줄 게시판 생성
create table videoBoard (
    videoBoardNum number constraint videoBoardNum primary key, -- 동영상 한 줄 게시판 고유번호
    videoNum number, -- 외래키
    memberNum number, -- 외래키
    videoReply VARCHAR2(300) NOT NULL
);

-- 동영상 한 줄 시퀀스 생성
create sequence videoBoardSeq
start with 1
increment by 1
nocache
nocycle;

-- 임의 데이터 삽입
INSERT INTO videoBoard
VALUES(videoBoardSeq.nextval,1,1,'한 줄 게시판 내용');

-- 동영상 한 줄 게시판 데이터 확인
select * from videoBoard;
------------------------------------------------------------
-- 대회 테이블 / 시퀀스 삭제
drop table league;
drop sequence leagueSeq;

-- 대회 테이블 게시판 생성
create table league (
    leagueNum number constraint leagueNum primary key, -- 대회 테이블 고유번호
    leagueName VARCHAR2(100) NOT NULL
);

-- 대회 테이블 시퀀스 생성
create sequence leagueSeq
start with 10
increment by 1
nocache
nocycle;

-- 임의 데이터 삽입
INSERT INTO league
VALUES(leagueSeq.nextval,'대회 이름');

-- 대회 테이블 데이터 확인
select * from league;
------------------------------------------------------------
-- 시즌 테이블 / 시퀀스 삭제
drop table season;
drop sequence seasonSeq;

-- 시즌 테이블 게시판 생성
create table season (
    seasonNum number constraint seasonNum primary key, -- 대회 테이블 고유번호
    seasonName VARCHAR2(100) NOT NULL
);

-- 시즌 테이블 시퀀스 생성
create sequence seasonSeq
start with 11
increment by 1
nocache
nocycle;

-- 임의 데이터 삽입
INSERT INTO season
VALUES(seasonSeq.nextval,'시즌 이름');

-- 시즌 테이블 데이터 확인
select * from season;
------------------------------------------------------------
-- 팀 테이블 / 시퀀스 삭제
drop table team;
drop sequence teamSeq;

-- 팀 테이블 게시판 생성
create table team (
    teamNum number constraint teamNum primary key, -- 대회 테이블 고유번호
    teamName VARCHAR2(100) NOT NULL
);
commit;

-- 팀 테이블 시퀀스 생성
create sequence teamSeq
start with 160
increment by 1
nocache
nocycle;

-- 임의 데이터 삽입
INSERT INTO team
VALUES(teamSeq.nextval,'팀1');

INSERT INTO team
VALUES(teamSeq.nextval,'팀2');

-- 시즌 테이블 데이터 확인
select * from season;
------------------------------------------------------------
-- 경기 일정 테이블 / 시퀀스 삭제
drop table matchSchedule;
drop sequence matchScheduleSeq;


-- 경기 일정 테이블 게시판 생성
create table matchSchedule (
    scheduleNum number constraint matchNum primary key, -- 경기 일정 고유번호
    leagueName varchar2(100), -- 리그 이름
    matchDate date, -- 경기 날짜
    matchTime varchar2(30), -- 경기 시간
    matchPlace varchar2(100), -- 경기 장소
    teamAName varchar2(100), -- A팀 이름
    teamAPoint number, -- A팀 점수
    teamBPoint number, -- B팀 점수
    teamBName varchar2(100), -- A팀 이름
    matchContent varchar2(30) -- 경기 내용
);

-- 경기일정 시퀀스 생성
create sequence matchScheduleSeq
start with 1
increment by 1
nocache
nocycle;


-- 임의 데이터 삽입
INSERT INTO matchSchedule
VALUES(matchScheduleSeq.nextval, '프리미어리그', '2023-05-06', '23:00', 'Etihad Stadium', '맨시티', 0, 5, '아스널', 'FT');
INSERT INTO matchSchedule
VALUES(matchScheduleSeq.nextval, '프리미어리그', '2023-05-07', '01:30', 'Anfield', '리버풀', 5, 0, '토트넘', 'FT');
INSERT INTO matchSchedule
VALUES(matchScheduleSeq.nextval, '프리미어리그', '2023-05-08', '', '경기가 없습니다.', '', '', '', '', 'NM');

SELECT * FROM matchSchedule;


-- 승부예측 테이블 생성
create table betting(
bettingNum number not null constraint bettingNum PRIMARY KEY,
scheduleNum number not null,
teamAValue NUMBER,
teamBValue NUMBER,
drawValue NUMBER
);

-- 승부예측 시퀀스 생성
create SEQUENCE bettingSEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;


-- 투표기록 테이블 생성
create table bettingRecord(
recordNum number not null CONSTRAINT recordNum PRIMARY KEY,
bettingNum number not null,
scheNum number not null,
memberNum number not null,
teamNum number not null,
bettingValue varchar2(10) not null
);

-- 투표기록 시퀀스 생성
create SEQUENCE bettingRecordSEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

-- 시즌 테이블 데이터 확인
select * from matchSchedule;
------------------------------------------------------------
-- 경기 결과 테이블 / 시퀀스 삭제
drop table matchResult;
drop sequence matchResultSeq;

-- 경기 결과 테이블 게시판 생성
create table matchResult(
    resultNum number constraint resultNum primary key, -- 결과 고유번호
    matchNum number, -- 외래키
    teamAResult varchar2(20),
    teamBResult varchar2(20),
    teamAPoint number,
    teamBPoint number
);

-- 경기 결과 시퀀스 생성
create sequence matchResultSeq
start with 1
increment by 1
nocache
nocycle;

-- 경기 결과 데이터 확인
select * from matchResult;

