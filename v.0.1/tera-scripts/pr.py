n=7
def check(n):
    x = True
    for i in range(2, n):
        if n%i == 0:
            x = False
            break
    if x:
        print("prime")
    else:
       print("not prime")
check(n)       

