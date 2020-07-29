 <div  align="center">    
 <img src="https://raw.githubusercontent.com/zhnnnnn/ZHNCosmos_GIFs/master/ZHNJSBox_demo_combine.png" width = "658" height = "470" alt="图片名称" align=center />
 </div>

## 0x0 描述
钟大的[JSBox](https://itunes.apple.com/cn/app/jsbox-%E5%88%9B%E9%80%A0%E4%BD%A0%E8%87%AA%E5%B7%B1%E7%9A%84%E5%B7%A5%E5%85%B7/id1312014438?mt=8)了解一下。核心其实就是一个动态化的框架，区别于一些DSL的页面动态化。js动态化做到了逻辑也能动态化。我这边实现了一个乞丐版的JSBox。基础的视图显示功能都已经加上，整体项目的架构已经搭建完成，如有需要稍微加加功能改改就能直接用。


实现的一些细节可以查看我在掘金上的文章 https://juejin.im/post/5b1a21bb5188254fbb756b23 


按我自己的理解，这样的引擎或者说方案其实可以说是破产版的weex（是不是听起来很唬人😀）。相比于一些歪门邪道的DSL动态化方案，我觉得通过JS来做才是正途。

## 0x1 示例代码

```
$ui.render({
  views: [
    {
      type: "view",
      props: {
        bgcolor: $color("#FF0000")
      },
      layout: function(make, view) {
        make.center.equalTo(view.super)
        make.size.equalTo($size(100, 100))
      },
      events: {
        tapped: function(sender) {

        }
      }
    }
  ]
})
```

## 0x2 功能
+ JavaScript to native页面
+ 代码编辑器(支持代码高亮)

