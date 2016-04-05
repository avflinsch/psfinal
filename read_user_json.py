import json
import pymysql 

conn = pymysql.connect(host='localhost', 
                       port=3306,
                       user='alex',
                       passwd='alex',
                       db='psfinal')
cur=conn.cursor()
                     
add_user = ("insert into users "
            "(user_id, name, review_count, average_stars, yelping_since,  "
            " funny_count, useful_count, cool_count, friend_count, "
            " fan_count, elite_count) "
            " values( %(user_id)s, %(name)s, %(review_count)s, "
            " %(average_stars)s, %(yelping_since)s,  "
            " %(funny_count)s, %(useful_count)s, %(cool_count)s, "
            " %(friend_count)s, %(fan_count)s, %(elite_count)s )")
                

add_elite = ("insert into user_elite (user_id, year_elite) "
             " values ( %(user_id)s, %(year_elite)s)")

add_friend = ("insert into friends (user_id, friend_id) "
              " values ( %(user_id)s, %(friend_id)s) ")

add_compliment = ("insert into compliments "
                  " (user_id, compliment_id, compliment_count ) "
                  " values (%(user_id)s, %(compliment_id)s, %(compliment_count)s)")
                  
cur.execute('truncate table users')
cur.execute('truncate table user_elite')
cur.execute('truncate table friends')
cur.execute('truncate table compliments')


def process(rec):
    d=json.loads(rec)
    votes=d['votes']
    
    data_user = { 'user_id'       : d['user_id'],
                  'name'          : d['name'].encode('utf-8'),
                  'review_count'  : d['review_count'],
                  'average_stars' : d['average_stars'],
                  'yelping_since' : d['yelping_since'],
                  'funny_count'   : votes['funny'],
                  'useful_count'  : votes['useful'],
                  'cool_count'    : votes['cool'],
                  'friend_count'  : len(d['friends']),
                  'fan_count'     : d['fans'],
                  'elite_count'   : len(d['elite'])
                 }
    cur.execute(add_user, data_user)  
    i=len(d['elite'])
    for j in range (0, i):
        data_elite = { 'user_id'   : d['user_id'],
                       'year_elite': d['elite'][j]
                     }
        cur.execute(add_elite, data_elite) 

    i=len(d['friends'])
    for j in range(0,i):
        data_friend= { 'user_id'   : d['user_id'],
                       'friend_id' : d['friends'][j]                     
                     }
        cur.execute(add_friend, data_friend)
    compliment_info=d['compliments']
    for key in compliment_info:
        compliment_id=key
        compliment_count=compliment_info[compliment_id]
        data_compliment={ 'user_id'          : d['user_id'],
                          'compliment_id'    : compliment_id,
                          'compliment_count' : compliment_count  
                        }
        cur.execute(add_compliment, data_compliment)
           
    



    
recds=0
with open('user.json') as f:
    for line in f:
        process(line)
        recds+=1
        if((recds%10)==0):
            cur.execute('commit')
        if((recds%5000)==0):    
            print('processed :'+str(recds))
        
conn.close()
print('processed :'+str(recds))
        