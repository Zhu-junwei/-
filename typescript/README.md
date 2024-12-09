# typescript笔记

## 坏境搭建

- 安装nodejs
- 安装typescript解析器
```
npm i -g typescript
```
查看安装的版本
```
tsc -v
```
现在安装的是`Version 5.7.2`。
 
编译ts文件

编写`.ts`文件，然后在使用tsc命令编译为js文件
`hello.ts`
```
console.log("Hello TS!")
```

编译ts文件
```
tsc hello.ts
```
可以发现同目录下出现了编译后的`hello.js`文件