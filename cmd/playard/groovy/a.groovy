int a=10
int b=0
println "a is ${a} , b is ${b}"
(a, b)=f1(a)
println "a is NOW ${a} , b is NOW ${b}"

def f1(int x) {
    return [x*10,x*20]
}
