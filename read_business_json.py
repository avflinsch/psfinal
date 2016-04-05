import json
import pymysql 

conn = pymysql.connect(host='localhost', 
                       port=3306,
                       user='alex',
                       passwd='alex',
                       db='psfinal')
cur=conn.cursor()
                     
add_business = ("insert into business "
                "(business_id, name, review_count, stars, "
                " latitude, longitude, city, state, full_address, is_open) "
                " values( %(business_id)s, %(name)s, %(review_count)s, "
                " %(stars)s, %(latitude)s, %(longitude)s, %(city)s, %(state)s, "
                " %(full_address)s, %(is_open)s )")
                
add_category = ("insert into business_categories"
                " (business_id, category) "
                " values( %(business_id)s, %(category)s)")


cur.execute('truncate table business')
cur.execute('truncate table business_categories')   
   
              
def process(rec):
    d=json.loads(rec)
    data_business = { 'business_id'   : d['business_id'],
                      'name'          : d['name'].encode('utf-8'),
                      'review_count'  : d['review_count'],
                      'stars'         : d['stars'],
                      'latitude'      : d['latitude'],
                      'longitude'     : d['longitude'],
                      'city'          : d['city'].encode('utf-8'),
                      'state'         : d['state'],
                      'full_address'  : d['full_address'].encode('unicode_escape'),
                      'is_open'       : d['open']
                      }
    cur.execute(add_business, data_business)    
    i=len(d["categories"])
    for j in range (0, i):
        data_category= { 'business_id' : d['business_id'],
                         'category'    : d["categories"][j]
                       }
        cur.execute(add_category, data_category)
    cur.execute('commit')



    
recds=0
with open('business.json') as f:
    for line in f:
        process(line)
        recds+=1
        if((recds%1000)==0):    
            print('processed :'+str(recds))
        
conn.close()
print('processed :'+str(recds))
        