# 학생 정보 등록 앱 GUI
# pip install pymysql
STDID = '학생번호'
STDNAME = '학생명'
STDPHONE = '휴대폰'
STDYEAR = '입학년도'
PADX = 20

# 관련 모듈 import
import tkinter as tk
from tkinter import * 
from tkinter import ttk, messagebox
from tkinter.font import *  

import pymysql  # mysql-connector 등 다른 모듈도 사용추천

## DB관련 설정
host = 'localhost'  # 127.0.0.1
port = 3306
database = 'madang'
username = 'madang'
password = 'madang'

def delEntry():
    global entID , entNAME , entPHONE, entYEAR , dataView
    entID.config(state='normal')
    entID.delete(0,END)
    entID.config(state='readonly')
    entNAME.delete(0,END)
    entPHONE.delete(0,END)
    entYEAR.delete(0,END)

## show data
def show_datas():
    '''
    connect DB - show datas in treeview
    '''
    global dataView
    conn = pymysql.connect(host=host,port=port,database=database,user=username,passwd=password)
    cursor = conn.cursor()
    query = """
            SELECT std_id, std_name, std_mobile, std_regyear
            FROM students
            """
    cursor.execute(query)
    data = cursor.fetchall()

    dataView.delete(*dataView.get_children())       # 트리뷰 리셋
    for i, (std_id,std_name,std_phone,std_regyear) in enumerate(data):
        dataView.insert("","end",values=(std_id,std_name,std_phone,std_regyear))    # 트리뷰 마지막에 'end' 추가는 한 줄의 끝을 의미함.

    cursor.close()
    conn.close()

def getData(event):
    '''
    Treeview 더블클릭으로 선택된 학생정보를 엔트리 위젯에 채우는 사용자 함수
    Args : 
        event : 트리뷰에서 발생하는 이벤트 객체
    '''
    global entID , entNAME , entPHONE, entYEAR , dataView

    ## 엔트리 위젯 기존 내용 삭제
    delEntry()

    ## 트리뷰 선택항목 ID 가져오기('I001')
    sel_item = dataView.selection()
    if sel_item:
        item_values = dataView.item(sel_item,'values')  # 선택항목 'values'(실데이터 가져오기)

    ## 엔트리에 각각 채워놓기
        entID.config(state='normal')
        entID.insert(0,item_values[0])
        entID.config(state='readonly')
        entNAME.insert(0,item_values[1])
        entPHONE.insert(0,item_values[2])
        entYEAR.insert(0,item_values[3])

## 새 학생정보 추가 함수
def addData():
    '''
    새 학생정보 DB 테이블 추가 사용자함수
    '''
    global entID , entNAME , entPHONE, entYEAR , dataView
    std_name, std_phone, std_year = entNAME.get() , entPHONE.get() , entYEAR.get()

    conn = pymysql.connect(host=host,port=port,database=database,user=username,passwd=password)
    cursor = conn.cursor()
    
    try:
        conn.begin()    # BEGIN 트랜잭션
        query = "INSERT INTO students (std_name, std_mobile, std_regyear) values (%s,%s,%s)"
        val = (std_name, std_phone, std_year)
        cursor.execute(query=query,args=val)
        conn.commit()
        lastid = cursor.lastrowid   # 마지막에 insert된 레코드 id를 가져옴(a_i)
        print(f"lastid : {lastid}")

        messagebox.showinfo('insert','학생 등록 성공!')
        delEntry()
        entNAME.focus_set()

    except Exception as e:
        print(e)
        conn.rollback() # 트랜잭션 롤백

    finally:
        cursor.close()
        conn.close()

    show_datas()

## 수정 함수
def modifyData():
    global entID , entNAME , entPHONE, entYEAR , dataView
    std_id, std_name, std_phone, std_year = entID.get() , entNAME.get() , entPHONE.get() , entYEAR.get()
    print(std_id)
    conn = pymysql.connect(host=host,port=port,database=database,user=username,passwd=password)
    cursor = conn.cursor()

    try:
        conn.begin()    # BEGIN 트랜잭션
        query = "UPDATE students SET std_name = %s, std_mobile = %s, std_regyear = %s WHERE std_id = %s;"
        val = (std_name, std_phone, std_year, std_id)
        cursor.execute(query=query,args=val)
        conn.commit()
        lastid = cursor.lastrowid   # 마지막에 insert된 레코드 id를 가져옴(a_i)
        print(f"lastid : {lastid}")
        messagebox.showinfo('알림','수정 완료!')
        delEntry()
        entNAME.focus_set()
    except Exception as e:
        print(e)
        conn.rollback() # 트랜잭션 롤백
    finally:
        cursor.close()
        conn.close()

    show_datas()
    
## 삭제 함수
def delData():
    global entID , dataView
    std_id = entID.get()
    print(std_id)
    conn = pymysql.connect(host=host,port=port,database=database,user=username,passwd=password)
    cursor = conn.cursor()

    try:
        yn = messagebox.askyesno('경고','정말 삭제하겠습니까?')
        if yn:
            conn.begin()    # BEGIN 트랜잭션
            query = "DELETE FROM students WHERE std_id = %s;"
            val = (std_id)
            cursor.execute(query=query,args=val)
            conn.commit()
            lastid = cursor.lastrowid   # 마지막에 insert된 레코드 id를 가져옴(a_i)
            print(f"lastid : {lastid}")
            messagebox.showinfo('알림','삭제 완료!')
            delEntry()
            entNAME.focus_set()
        else: messagebox.showinfo('알림','삭제가 취소되었습니다.')
    except Exception as e:
        print(e)
        conn.rollback() # 트랜잭션 롤백
    finally:
        cursor.close()
        conn.close()

    show_datas()

## 검색 함수
def searchData():
    s_data = entSEARCH.get()
    conn = pymysql.connect(host=host,port=port,database=database,user=username,passwd=password)
    cursor = conn.cursor()
    try:
        if s_data:
            conn.begin()    # BEGIN 트랜잭션
            query = "SELECT std_id, std_name, std_mobile, std_regyear FROM students WHERE std_name LIKE %s"
            val = ("%"+s_data+"%",)
            cursor.execute(query=query,args=val)
            conn.commit()
            entSEARCH.focus_set()
            data = cursor.fetchall()
            dataView.delete(*dataView.get_children())       # 트리뷰 리셋
            for i, (std_id,std_name,std_phone,std_regyear) in enumerate(data):
                dataView.insert("","end",values=(std_id,std_name,std_phone,std_regyear))
        else: show_datas()
    except Exception as e:
        print(e)
        conn.rollback() # 트랜잭션 롤백
    finally:
        cursor.close()
        conn.close()


## tkinter UI 설정
root = Tk()
root.geometry('830x500')
root.title('학생정보 등록앱')
root.resizable(False,False)
root.iconbitmap('./img/students.ico')

myFont = Font(family='NanumGothic', size=10) 

## UI 구성
## LABELS
label = tk.Label(root,text=STDID,font =myFont).place(x=62+(PADX),y=10)
label = tk.Label(root,text=STDNAME,font =myFont).place(x=268+(PADX),y=10)
label = tk.Label(root,text=STDPHONE,font =myFont).place(x=468+(PADX),y=10)
label = tk.Label(root,text=STDYEAR,font =myFont).place(x=665+(PADX),y=10)

## ENTRYS
entID = tk.Entry(root,font=myFont,width=10)
entID.config(state='readonly', foreground='blue', disabledforeground='blue') 
entID.place(x=47+(PADX),y=30)
entNAME = tk.Entry(root,font=myFont,width=12)
entNAME.place(x=240+(PADX),y=30)
entPHONE = tk.Entry(root,font=myFont)
entPHONE.place(x=410+(PADX),y=30)
entYEAR = tk.Entry(root,font=myFont, width=13)
entYEAR.place(x=638+(PADX),y=30)
entSEARCH = tk.Entry(root,font=myFont,width=12)
entSEARCH.place(x=620,y=75)

## BUTTONS
tk.Button(root,text='추가',font=myFont, height=2,width=12, border=1,bg='pink',relief='raised',command=addData).place(x=240,y=65)
tk.Button(root,text='수정',font=myFont, height=2,width=12, border=1,bg='pink',relief='raised',command=modifyData).place(x=350,y=65)
tk.Button(root,text='삭제',font=myFont, height=2,width=12, border=1,bg='pink',relief='raised',command=delData).place(x=460,y=65)
tk.Button(root,text='이름검색',font=myFont, height=1,width=7, border=1,bg='pink',relief='raised',command=searchData).place(x=730,y=72)

## FRAME
treeFrame = ttk.Frame(root)
treeFrame.place(x=10,y=125)
## TREEVIEW
cols = (STDID,STDNAME,STDPHONE,STDYEAR)
dataView = ttk.Treeview(treeFrame, columns=cols, show='headings',height=16)

scroll_y = ttk.Scrollbar(treeFrame, orient="vertical", command=dataView.yview)
scroll_y.grid(row=1, column=3, sticky='ns')
dataView.configure(yscrollcommand=scroll_y.set)

for col in cols:
    dataView.heading(col,text=col)
    dataView.grid(row=1, column=0, columnspan=2)
    


if __name__ == "__main__":
    show_datas()
    dataView.bind('<Double-Button-1>',func=getData)
    root.mainloop()



