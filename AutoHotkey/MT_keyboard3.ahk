; Multi-tap direct input



^!a::
{
	MultiTap(":a:send a, :b:send b, :c:send c, :2:send 2",1000)
	SoundBeep,2033,100
	SplashTextOn,15,, 2
	SplashTextOff
} Return


^!d::
{
	MultiTap(":d:send d, :e:send e, :f:send f, :3:send 3",1000)
	SoundBeep,2174,100
	SplashTextOn,15,, 3
	SplashTextOff
} Return

^!g::
{
	MultiTap(":g:send g, :h:send h, :i:send i, :4:send 4",1000)
	SoundBeep,1979,100
	SplashTextOn,15,, 4
	SplashTextOff
} Return

^!j::
{
	MultiTap(":j:send j, :k:send k, :l:send l, :5:send 5",1000)
	SoundBeep,2106,100
	SplashTextOn,15,, 5
	SplashTextOff
} Return

^!m::
{
	MultiTap(":m:send m, :n:send n, :o:send o, :6:send 6",1000)
	SoundBeep,2247,100
	SplashTextOn,15,, 6
	SplashTextOff
} Return

^!p::
{
	MultiTap(":p:send p, :q:send q, :r:send r, :s:send s, :7:send 7",1000)
	SoundBeep,2061,100
	SplashTextOn,15,, 7
	SplashTextOff
} Return

^!t::
{
	MultiTap(":t:send t, :u:send u, :v:send v, :8:send 8",1000)
	SoundBeep,2188,100
	SplashTextOn,15,, 8
	SplashTextOff
} Return

^!w::
{
	MultiTap(":w:send w, :x:send x, :y:send y, :z:send z, :9:send 9",1000)
	SoundBeep,2329,100
	SplashTextOn,15,, 9
	SplashTextOff
} Return

^!-::
{
	MultiTap(":-:send {-}, send {:}, :@:send {@}, :.:send {.}, :0:send {0}, :1:send {1}",1000)
	SoundBeep,1906,100
	SplashTextOn,15,, 1
	SplashTextOff
} Return

;, . ? @ ! - + / * ( ) "" : % $ #
;+ % # ,



+^!a::
{
	MultiTap(":A:send A, :B:send B, :C:send C, :2:send 2",1000)
	SoundBeep,2033,100
	SplashTextOn,45,, ^2^
	SplashTextOff
} Return


+^!d::
{
	MultiTap(":D:send D, :E:send E, :F:send F, :3:send 3",1000)
	SoundBeep,2174,100
	SplashTextOn,45,, ^3^
	SplashTextOff
} Return

+^!g::
{
	MultiTap(":G:send G, :H:send H, :I:send I, :4:send 4",1000)
	SoundBeep,1979,100
	SplashTextOn,45,, ^4^
	SplashTextOff
} Return

+^!j::
{
	MultiTap(":J:send J, :K:send K, :L:send L, :5:send 5",1000)
	SoundBeep,2106,100
	SplashTextOn,45,, ^5^
	SplashTextOff
} Return

+^!m::
{
	MultiTap(":M:send M, :N:send N, :O:send O, :6:send 6",1000)
	SoundBeep,2247,100
	SplashTextOn,45,, ^6^
	SplashTextOff
} Return

+^!p::
{
	MultiTap(":P:send P, :Q:send Q, :R:send R, :S:send S, :7:send 7",1000)
	SoundBeep,2061,100
	SplashTextOn,45,, ^7^
	SplashTextOff
} Return

+^!t::
{
	MultiTap(":T:send T, :U:send U, :V:send V, :8:send 8",1000)
	SoundBeep,2188,100
	SplashTextOn,45,, ^8^
	SplashTextOff
} Return

+^!w::
{
	MultiTap(":W:send W, :X:send X, :Y:send Y, :Z:send Z, :9:send 9",1000)
	SoundBeep,2329,100
	SplashTextOn,45,, ^9^
	SplashTextOff
} Return

+^!-::
{
	MultiTap(":+:send {+}, :%:send {%}, :#:send {#}",1000)
	SoundBeep,1906,100
	SplashTextOn,45,, ^1^
	SplashTextOff
} Return

;+ % # ,
