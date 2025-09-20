# redis는 0~15번까지의 database로 구성
select db번호

# 데이터베이스 내 모든 키 조회
keys *

# 일반적인 String 구조
# set을 통해 key:value 세팅
set user:email:1 hong1@naver.com

# nx : 이미 존재하면 pass, 없으면 set
set user:email:2 hong2@naver.com nx

# xx : 없으면 pass, 이미 존재하면 set
set user:email:2 hong2@naver.com xx

# ex(expiration) : 만료시간(초단위), ttl(time to live)
set user:email:3 hong3@naver.com ex 10

# redis 활용 : 사용자 인증정보 저장(ex-refresh 토큰)
set user:1:refresh_token eklewjklfjawlk ex  100000

# 특정 key 삭제
del user:email:1

# 현재 DB 내 모든 key 삭제
flushdb

# redis 활용 : 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 # 특정 key값의 value를 1만큼 증가
decr likes:posting:1 # 특정 key값의 value를 1만큼 감소
get likes:posting:1

# redis 활용 : 재고관리
set stocks:proudct:1 100
decr stocks:product:1
get stocks:product:1

# redis 활용 : 캐시(임시저장) 기능 구현
set posting:1 "{\"title\": \"hello java\", \"contents\": \"hello java is ...\", \"author_email\": \"hong@naver.com\" }" ex 100

# list 자료구조 : redis의 list는 deque 자료구조
# lpush : 데이터를 왼쪽 끝에 삽입
# rpush : 데이터를 오른쪽 끝에 삽입
# lpop : 데이터를 왼쪽에서 꺼내기
# rpop : 데이터를 오른쪽에서 꺼내기

lpush hongildongs hong1
lpush hongildongs hong2
rpush hongildongs hong3
rpop hongildongs
lpop hongildongs

# list 조회
# -1 은 리스트의 끝자리(마지막index)를 의미. -2 는 끝에서 2번째를 의미
lrange hongildongs 0 0 # 첫번째 값만 조회
lrange hongildongs -1 -1 # 마지막 값만 조회
lrange hongildongs 0 -1 # 처음부터 끝까지
lrange hongildongs -3 -1 # 마지막 2번째부터 마지막자리까지
lrange hongildongs 0 1 # 처음부터 2번째자리까지
 
# 데이터 개수 조회
llen hongildongs

# ttl 적용
expire hongildongs 20

# ttl 조회
ttl hongildongs

# redis 활용 : 최근 방문한 페이지, 최근 조회한 상품 목록
# list 자료형을 사용할 경우 중복을 제거할 순 없다. 이 부분은 zset 자료형을 사용하면 해결할 수 있다.
rpush mypages www.naver.com
rpush mypages www.google.com
rpush mypages www.daum.net
rpush mypages www.chatgpt.com
rpush mypages www.daum.net

# 최근 방문한 페이지 3개만 보여주는
lrange mypages -3 -1

# set 자료구조 : 중복 없음. 순서 없음
# key value 형식인 것은 똑같다

# set에 값 추가
sadd memberlist member1
sadd memberlist member2

# set 조회
smembers memberlist

# set 요소의 개수 조회
# scard = s cardinality
scard memberlist

# set에서 멤버 제거
srem memberlist member2

# 특정 요소가 set 안에 들어있는지 확인
sismember memberlist member1

# redis set 활용 : 좋아요 구현
sadd likes:posting:1 member1
sadd likes:posting:1 member2
sadd likes:posting:1 member1

# 좋아요 개수
scard likes:posting:1

# 좋아요 눌렀는지 안눌렀는지 확인
sismember likes:posting:1 member1