; Multi-tap direct input

	

^!a::
{
	MultiTap("::send a, ::send b, ::send c, ::send 2",500)
	SoundBeep,2033,100
	SplashTextOn,15,, 2
	SplashTextOff
} Return


^!d::
{
	MultiTap("::send d, ::send e, ::send f, ::send 3",500)
	SoundBeep,2174,100
	SplashTextOn,15,, 3
	SplashTextOff
} Return

^!g::
{
	MultiTap("::send g, ::send h, ::send i, ::send 4",500)
	SoundBeep,1979,100
	SplashTextOn,15,, 4
	SplashTextOff
} Return

^!j::
{
	MultiTap("::send j, ::send k, ::send l, ::send 5",500)
	SoundBeep,2106,100
	SplashTextOn,15,, 5
	SplashTextOff
} Return

^!m::
{
	MultiTap("::send m, ::send n, ::send o, ::send 6",500)
	SoundBeep,2247,100
	SplashTextOn,15,, 6
	SplashTextOff
} Return

^!p::
{
	MultiTap("::send p, ::send q, ::send r, ::send s, ::send 7",500)
	SoundBeep,2061,100
	SplashTextOn,15,, 7
	SplashTextOff
} Return

^!t::
{
	MultiTap("::send t, ::send u, ::send v, ::send 8",500)
	SoundBeep,2188,100
	SplashTextOn,15,, 8
	SplashTextOff
} Return

^!w::
{
	MultiTap("::send w, ::send x, ::send y, ::send z, ::send 9",500)
	SoundBeep,2329,100
	SplashTextOn,15,, 9
	SplashTextOff
} Return
	
^!-::
{
	MultiTap("send {-}, send {:}, send {@}, send {.}, send {0}, send {1}",500)
	SoundBeep,1906,100
	SplashTextOn,15,, 1
	SplashTextOff
} Return

;, . ? @ ! - + / * ( ) "" : % $ #




+^!a::
{
	MultiTap("::send A, ::send B, ::send C, ::send 2",500)
	SoundBeep,2033,100
	SplashTextOn,45,, ^2^
	SplashTextOff
} Return


+^!d::
{
	MultiTap("::send D, ::send E, ::send F, ::send 3",500)
	SoundBeep,2174,100
	SplashTextOn,45,, ^3^
	SplashTextOff
} Return

+^!g::
{
	MultiTap("::send G, ::send H, ::send I, ::send 4",500)
	SoundBeep,1979,100
	SplashTextOn,45,, ^4^
	SplashTextOff
} Return

+^!j::
{
	MultiTap("::send J, ::send K, ::send L, ::send 5",500)
	SoundBeep,2106,100
	SplashTextOn,45,, ^5^
	SplashTextOff
} Return

+^!m::
{
	MultiTap("::send M, ::send N, ::send O, ::send 6",500)
	SoundBeep,2247,100
	SplashTextOn,45,, ^6^
	SplashTextOff
} Return

+^!p::
{
	MultiTap("::send P, ::send Q, ::send R, ::send S, ::send 7",500)
	SoundBeep,2061,100
	SplashTextOn,45,, ^7^
	SplashTextOff
} Return

+^!t::
{
	MultiTap("::send T, ::send U, ::send V, ::send 8",500)
	SoundBeep,2188,100
	SplashTextOn,45,, ^8^
	SplashTextOff
} Return

+^!w::
{
	MultiTap("::send W, ::send X, ::send Y, ::send Z, ::send 9",500)
	SoundBeep,2329,100
	SplashTextOn,45,, ^9^
	SplashTextOff
} Return

+^!-::
{
	MultiTap(":-:send {-}, send {:}, :@:send {@}, :.:send {.}, :0:send {0}, :1:send {1}",500)
	SoundBeep,1906,100
	SplashTextOn,45,, ^1^
	SplashTextOff
} Return