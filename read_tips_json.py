import json
import pymysql 

conn = pymysql.connect(host='localhost', 
                       port=3306,
                       user='alex',
                       passwd='alex',
                       db='psfinal')
cur=conn.cursor()
                     
add_tip = ("insert into tips "
           "(business_id, user_id, date, likes, text )"
           " values( %(business_id)s, %(user_id)s,  "
           " %(date)s, %(likes)s, "
           "  %(text)s )")
                
             
cur.execute('truncate table tips')

def process(rec):
    d=json.loads(rec)
  
    data_tip = { 'business_id'   : d['business_id'],
                 'user_id'       : d['user_id'],
                 'date'          : d['date'],
                 'likes'         : d['likes'],
                 'text'          : d['text'].encode('unicode_escape')
               }
    cur.execute(add_tip, data_tip)           
    cur.execute('commit')



    
recds=0
with open('tip.json') as f:
    for line in f:
        process(line)
        recds+=1
        if((recds%2000)==0):    
            print('processed :'+str(recds))
        
conn.close()
print('processed :'+str(recds))
        