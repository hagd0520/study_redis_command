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
