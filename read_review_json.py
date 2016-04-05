import json
import pymysql 

conn = pymysql.connect(host='localhost', 
                       port=3306,
                       user='alex',
                       passwd='alex',
                       db='psfinal')
cur=conn.cursor()
                     
add_review = ("insert into reviews "
              "(business_id, user_id, stars, date,  "
              " funny_count, useful_count, cool_count, text) "
              " values( %(business_id)s, %(user_id)s, %(stars)s, %(date)s, "
              " %(funny_count)s, %(useful_count)s, %(cool_count)s, %(text)s )")
                
             
cur.execute('truncate table reviews')

def process(rec):
    d=json.loads(rec)
    votes=d['votes']
  
    data_review = {   'business_id'   : d['business_id'],
                      'user_id'       : d['user_id'],
                      'stars'         : d['stars'],
                      'date'          : d['date'],
                      'funny_count'   : votes['funny'],
                      'useful_count'  : votes['useful'],
                      'cool_count'    : votes['cool'],
                      'text'          : d['text'].encode('unicode_escape')
                      }
    cur.execute(add_review, data_review)           
    cur.execute('commit')



    
recds=0
with open('review.json') as f:
    for line in f:
        process(line)
        recds+=1
        if((recds%2000)==0):    
            print('processed :'+str(recds))
        
conn.close()
print('processed :'+str(recds))
        