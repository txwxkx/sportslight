-- SPORTSLIGHT 테이블 ver.1.8

/*
목차
1. 초기화
2. 테이블, 시퀸스생성
3. 외래키 생성
*/

-- 1. 초기화
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

-- 2. 테이블, 시퀸스생성
-----------------------------------------------------------------

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

-- 임의 데이터 삽입
INSERT INTO memberz
VALUES('1', 'ktw@gmail.com', 'ktw1234', '태우버거', '2023-03-15', '1', '1');
INSERT INTO memberz
VALUES('2', 'sjc@naver.com', 'sjc1234', '설조장', '2023-04-01', '1', '1');
INSERT INTO memberz
VALUES('3', 'ksj@daum.net', 'ksj1234', '리차드킴', '2023-04-19', '1', '1');

select * from memberz;

commit;

-----------------------------------------------------------------
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

select * from memberFavor;

commit;

-----------------------------------------------------------------
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

select * from adminz;

commit;

-----------------------------------------------------------------
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

select * from notice;

commit;

------------------------------------------------------------
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

select * from video;

commit;

------------------------------------------------------------
-- 동영상 한 줄 게시판 생성
create table videoBoard (
    videoBoardNum number constraint videoBoardNum primary key, -- 동영상 한 줄 게시판 고유번호
    videoNum number, -- 외래키
    memberNum number, -- 외래키
    videoReply VARCHAR2(300) NOT NULL,
    constraint videoBoard_dc
    foreign key (videoNum) -- 해당 테이블의 FK 설정
    references video(videoNum) -- mother table의 pk와 연결
    on delete cascade
);

-- 동영상 한 줄 시퀀스 생성
create sequence videoBoardSeq
start with 1
increment by 1
nocache
nocycle;

select * from videoBoard;

commit;

-----------------------------------------------------------------

drop table footballTalk;

drop SEQUENCE footballTalkSEQ;

-- 축구토크 게시판 테이블 생성
create table footballTalk(
talkNum number not null CONSTRAINT talkNum PRIMARY KEY,
memberNum number not null,
leagueNum number not null,
talkTitle varchar2(300) not null,
talkContent varchar2(3000) not null,
talkUpload varchar2(3000),
regDate date not null,
talkViews number default 0
);

-- 축구토크 게시판 시퀸스 생성
create SEQUENCE footballTalkSEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

-- 임의 데이터 삽입
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '1', '아스날 우승 기원', 'ㅈㄱㄴ', '', '2023-04-22', '1');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '2', '이강인 폼 미쳤다', 'ㅈㄱㄴ', '', '2023-04-23', '2');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '3', '3', '뮌헨 왜 이러나요??', 'ㅈㄱㄴ', '', '2023-04-24', '25');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '4', '김민재 어디 가려나요??', 'ㅈㄱㄴ', '', '2023-04-25', '24');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '5', '음바페 닌자 거북이 닮음', 'ㅈㄱㄴ', '', '2023-04-26', '23');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '3', '6', '[오피셜]챔스 4강 대진 확정', 'ㅈㄱㄴ', '', '2023-04-27', '22');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '7', '유로파 우승 누가 할꺼 같음??', 'ㅈㄱㄴ', '', '2023-04-28', '21');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '8', '기성용 진짜 잘하네', 'ㅈㄱㄴ', '', '2023-04-29', '20');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '3', '9', '평택 승격 가즈아', 'ㅈㄱㄴ', '', '2023-04-30', '19');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '1', '아스날 우승 기원', 'ㅈㄱㄴ', '', '2023-05-01', '18');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '2', '이강인 폼 미쳤다', 'ㅈㄱㄴ', '', '2023-05-02', '17');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '3', '3', '뮌헨 왜 이러나요??', 'ㅈㄱㄴ', '', '2023-05-03', '16');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '4', '김민재 어디 가려나요??', 'ㅈㄱㄴ', '', '2023-05-04', '15');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '5', '음바페 닌자 거북이 닮음', 'ㅈㄱㄴ', '', '2023-05-05', '14');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '3', '6', '[오피셜]챔스 4강 대진 확정', 'ㅈㄱㄴ', '', '2023-05-06', '13');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '7', '유로파 우승 누가 할꺼 같음??', 'ㅈㄱㄴ', '', '2023-05-07', '12');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '8', '기성용 진짜 잘하네', 'ㅈㄱㄴ', '', '2023-05-08', '11');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '3', '9', '평택 승격 가즈아', 'ㅈㄱㄴ', '', '2023-05-09', '10');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '1', '아스날 우승 기원', 'ㅈㄱㄴ', '', '2023-05-10', '9');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '2', '이강인 폼 미쳤다', 'ㅈㄱㄴ', '', '2023-05-11', '8');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '3', '3', '뮌헨 왜 이러나요??', 'ㅈㄱㄴ', '', '2023-05-12', '7');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '1', '4', '김민재 어디 가려나요??', 'ㅈㄱㄴ', '', '2023-05-13', '6');
INSERT INTO footballTalk VALUES(footballTalkSEQ.nextval, '2', '5', '음바페 닌자 거북이 닮음', 'ㅈㄱㄴ', '', '2023-05-14', '5');

SELECT * FROM footballTalk;

commit;

-----------------------------------------------------------------

drop table footballTalkReply;

drop SEQUENCE footballTalkReplySEQ;

-- 축구토크 댓글 게시판 테이블 생성
create table footballTalkReply(
talkReplyNum number not null CONSTRAINT talkReplyNum PRIMARY KEY,
talkNum number not null,
memberNum number not null,
talkReplyContent varchar2(300) not null,
regDate date not null,
constraint talkReply_cd
    foreign key (talkNum) -- 해당 테이블의 FK 설정
    references footballTalk(talkNum) -- mother table의 pk와 연결
    on delete cascade
);

-- 축구토크 댓글 시퀸스 생성
create SEQUENCE footballTalkReplySEQ
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

INSERT INTO footballTalkReply VALUES(footballTalkReplySEQ.nextval, '1', '1', '아스날 우승 기원 1일차', '2023-05-13');
INSERT INTO footballTalkReply VALUES(footballTalkReplySEQ.nextval, '1', '2', '어차피 맨시티가 우승함 ㅅㄱ', '2023-05-14');
INSERT INTO footballTalkReply VALUES(footballTalkReplySEQ.nextval, '1', '1', '아스날 내년 우승 기원 1일차', '2023-05-15');
INSERT INTO footballTalkReply VALUES(footballTalkReplySEQ.nextval, '1', '3', '맨유도 껴줘..', '2023-05-16');
INSERT INTO footballTalkReply VALUES(footballTalkReplySEQ.nextval, '1', '1', 'ㅠㅠ', sysdate);

select * from footballTalkReply;

commit;

-----------------------------------------------------------------
-- 좋아요 게시판 생성
create table heart (
    likeNum number constraint likeNum primary key, -- 좋아요 고유번호
    memberNum number, -- 외래키
    videoNum number, -- 외래키
    CONSTRAINT heart_cd
    FOREIGN KEY (videoNum) 
    REFERENCES video(videoNum)
    on delete cascade
);

-- 좋아요 테이블 시퀀스 생성
create sequence heartSeq
start with 1
increment by 1
nocache
nocycle;

select * from heart;

commit;

------------------------------------------------------------
-- 즐겨찾기 테이블 생성
create table favorite (
    favoriteNum number constraint favoriteNum primary key, -- 즐겨찾기 고유번호
    memberNum number, -- 외래키
    videoNum number, -- 외래키
    CONSTRAINT favorite_cd
    FOREIGN KEY (videoNum) 
    REFERENCES video(videoNum)
    on delete cascade
);

-- 즐겨찾기 시퀀스 생성
create sequence favoriteSeq
start with 1
increment by 1
nocache
nocycle;

select * from favorite;

commit;

------------------------------------------------------------
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

select * from league;

commit;

------------------------------------------------------------
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

select * from season;

commit;

------------------------------------------------------------
-- 팀 테이블 게시판 생성
create table team (
    teamNum number constraint teamNum primary key, -- 대회 테이블 고유번호
    teamName VARCHAR2(100) NOT NULL
);

-- 팀 테이블 시퀀스 생성
create sequence teamSeq
start with 160
increment by 1
nocache
nocycle;

select * from team;

commit;

------------------------------------------------------------
-- 경기 일정 테이블 게시판 생성
create table matchSchedule (
    scheduleNum number constraint scheduleNum primary key, -- 경기 일정 고유번호
    leagueName varchar2(100), -- 리그 이름
    leagueYM varchar2(30), -- 리그 연월
    matchDate date, -- 경기 날짜
    matchTime varchar2(30), -- 경기 시간
    matchPlace varchar2(100), -- 경기 장소
    teamAName varchar2(100), -- A팀 이름
    teamAPoint number, -- A팀 점수
    teamBPoint number, -- B팀 점수
    teamBName varchar2(100), -- A팀 이름
    matchContent varchar2(30) -- 경기 내용
);

-- 경기 일정 시퀀스 생성
create sequence matchScheduleSeq
start with 1
increment by 1
nocache
nocycle;

select * from matchSchedule;

commit;

-----------------------------------------------------------
-------------------------------------------------------------
----------------------------------------------------------------

insert into video
values(1, 'test', 'aaa', 'aaa', 0, 'l', 1,2,3,4);

insert into videoboard
values(1, 1, 1, 'asdf');

insert into heart
values(1, 1, 1);

insert into favorite
values(1, 1, 1);

insert into footballtalk
values(1, 1, 1, 'aaa', 'aaaa', 'aaa', sysdate, 0);

insert into footballtalkreply
values(1, 1, 1, 'awuiegfhai', sysdate);

select * from footballtalk;
select * from footballtalkreply;

delete from footballtalk where talknum =1;

commit;

delete from video where videonum = 1;

select * from video;
select * from heart;
select * from favorite;
select * from videoboard;

SELECT b.*, l.leagueName, m.memberProfile
        FROM (
            SELECT ROWNUM AS rn, a.*
            FROM (
                SELECT f.*, m.memberNum
                FROM footballTalk f
                LEFT JOIN memberz m ON f.memberNum = m.memberNum
                ORDER BY talkNum DESC
            ) a
        ) b
        LEFT JOIN league l ON b.leagueNum = l.leagueNum
        LEFT JOIN memberz m ON b.memberNum = m.memberNum
        WHERE b.rn >= '1' AND b.rn <= '5';
        
SELECT b.*, l.leagueName
FROM (
    SELECT ROWNUM AS rn, a.*
    FROM (
        SELECT f.*, m.memberProfile
        FROM footballTalk f
        LEFT JOIN memberz m ON f.memberNum = m.memberNum
        ORDER BY talkNum DESC
    ) a
    JOIN (
        SELECT leagueNum, leagueName
        FROM league
    ) l ON a.leagueNum = l.leagueNum
) b
WHERE b.rn >= '1' AND b.rn <= '5';

SELECT b.*, l.leagueName, m.memberProfile
    FROM (
      SELECT ROWNUM AS rn, a.*
      FROM (
        SELECT f.*, m.memberNum
        FROM footballTalk f
        LEFT JOIN memberz m ON f.memberNum = m.memberNum
        ORDER BY talkNum DESC
      ) a
    ) b
    LEFT JOIN league l ON b.leagueNum = l.leagueNum
    LEFT JOIN memberz m ON b.memberNum = m.memberNum
    WHERE b.rn >= '1' AND b.rn <= '5';
    
  
        	SELECT b.*
	   		FROM(SELECT ROWNUM AS rn, a.*
		   	 	 FROM(SELECT f.*, m.memberProfile
		   			  FROM footballTalk f, memberz m
		   			  WHERE f.memberNum = m.memberNum(+)
		   			  ORDER BY talkNum DESC)a)b;

SELECT f.*, l.leagueName, m.memberProfile
FROM footballtalk f
JOIN league l ON f.leagueNum = l.leagueNum
JOIN memberz m ON f.memberNum = m.memberNum;

SELECT b.*
FROM(SELECT ROWNUM AS rn, a.*
     FROM(SELECT f.*, l.leagueName, m.memberProfile
          FROM footballtalk f
          JOIN league l ON f.leagueNum = l.leagueNum
          JOIN memberz m ON f.memberNum = m.memberNum
          ORDER BY talkNum DESC)a)b
WHERE b.rn >= #{startRow} AND b.rn <= #{endRow};