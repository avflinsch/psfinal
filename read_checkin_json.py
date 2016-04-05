import json
import pymysql 

conn = pymysql.connect(host='localhost', 
                       port=3306,
                       user='alex',
                       passwd='alex',
                       db='psfinal')
cur=conn.cursor()
                     
add_checkin = ("insert into checkins "
               "(business_id,  checkin_id, checkins, hour_of_day, day_of_week  )"
               " values( %(business_id)s, %(checkin_id)s, %(checkins)s, "
               " %(hour_of_day)s, %(day_of_week)s ) "
                )
                
             
cur.execute('truncate table checkins')

def process(rec):
    d=json.loads(rec)
    checkin_info=d['checkin_info']
    for key in checkin_info:
        checkin_id = key
        # key fmt is hour - day
        hour_of_day, day_of_week = key.split('-',2)
        checkins = checkin_info[checkin_id]
        data_checkin = {'business_id' : d['business_id'],
                        'checkin_id'  : checkin_id,
                        'checkins'    : checkins,
                        'hour_of_day' : hour_of_day,
                        'day_of_week' : day_of_week
                       }
        cur.execute(add_checkin, data_checkin)           
    cur.execute('commit')



    
recds=0
with open('checkin.json') as f:
    for line in f:
        process(line)
        recds+=1
        if((recds%2000)==0):    
            print('processed :'+str(recds))
        
conn.close()
print('processed :'+str(recds))
        