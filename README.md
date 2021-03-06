# 笔记-iOS多环境配置

## 前言

​	在iOS发开中，经常会遇到多环境的情况，例如网络请求链接就分为开发，测试，正式。经常调试程序也需要用到假数据，在同样的逻辑中，写开发数据，正式数据。等调试完必须将开发用的变量删除掉，如果在多处的调试，往往可能忘记删除开发数据，上线，导致事故。笔者曾经就遇到过这样的情况，由于不想每次开发输入登录账号密码，边将账号密码写死，最后因为忘记注释掉，上线导致问题。还好使用用户不多，没有被追究。但是那个时候笔者就暗下决心，必须使用多环境来管理，不然就会暗藏bug，开发中也会导致不必要的麻烦，提高开发的效率。

​	需求：由于开发中不需要对不同的系统库，三方库使用多环境管理。使用最多的就是不同环境的常量，代码，项目配置涉及到多环境。根据三个需求设置多环境。

## 一.利用Build Configuration来配置多环境

![](https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306170726597.png" alt="image-20210306170726597)



<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306170726597.png" alt="image-20210306170726597" width= "50%" align='left' />  



​	根据常见的开发场景，开发，测试和线上三个场景。分别创建对应的Configurations:Debug、Internal和AppStore。集中Internal是Duplicate "Debug" 生成的。这里设置三种场景主要是设置编译、打包的条件。



​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306171125300.png" alt="image-20210306171125300" style="zoom:50%;" />	  

​	创建新的Scheme

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306171244799.png" alt="image-20210306171244799"  width= "50%" align='left'/>  



​	笔者在这里为了区分不同的scheme,加上了一个后缀，方便在使用的时候能够做到一个区分。

​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306171428769.png" alt="image-20210306171428769"  width= "60%" align='left' />  











​	只有将scheme对应不同的Configuration,我们的设置才知道我们对应的环境是什么。

​	分别将Debug对应Debug，Test对应Internal,Release对应AppStore。

​	这样我们就能用不同的scheme来区分不同的使用场景了。

## 二、使用xcconfig设置项目配置

​	第一部分，已经区分出了三个开发环境，那么我们如何去设置不同的项目配置呢？

​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306172040293.png" alt="image-20210306172040293"  width= "70%" align='left'/>  



​	

​	以Build Active Architecture Only 为例，因为我们设置了不同的Configuration，我们在这里也让我们在不同的环境有多种不同的选择。

​	其实到这里已经满足了我们进行不同配置的需求，但是因为这种方式是对于项目的。当我们项目有多个的时候，使用这种方式来配置项目其实是很麻烦的。且容易出错。因为不知道什么时候我们就会错误的去做一个选择，且后面可能忘记配置了什么。

​	这个时候就需要使用xcconfig来配置了。

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306172931545.png" alt="image-20210306172931545"  width= "30%" align='left'/>  



​	在项目中添加xcconfig文件，上图是我管理的方式。

​		<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306173020623.png" alt="image-20210306173020623"  width= "50%" align='left'/>  



​	







​	如果使用Pods来管理的话，设置上会对应Pods的配置。针对使用Pods的朋友，在添加scheme后，需要重新pod install，这样pod会创建新的配置。

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306173239251.png" alt="image-20210306173239251"  width= "50%" align='left' />  



​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306173415812.png" alt="image-20210306173415812"  width= "50%" align='left' />  









​	将我们的配置文件，与对应的Configuration绑定。

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306173458488.png" alt="image-20210306173458488"  width= "90%" align='left' />  



​	这个时候运行会报错。提示重新 pod install。

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306173547202.png" alt="image-20210306173547202"  width= "90%" align='left' />  



​	重新pod install后会有警告。是提示Pods的配置没有被引用。

​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306174242208.png" alt="image-20210306174242208"  width= "80%" align='left' />  



​	







将pods 配置文件在对应的xcconfig引入。

​	`#include "Pods/Target Support Files/Pods-MultiEnvironmentLearning/Pods-MultiEnvironmentLearning.debug.xcconfig"`

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306174424831.png" alt="image-20210306174424831"  width= "90%" align='left' />  



​	再次pod install 会发现警告没有了。

​	再次Run，运行正常。

​	下面来测试一下效果，为了测试在xcconfig中配置参数是否有效。

​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306175233016.png" alt="image-20210306175233016"  width= "90%" align='left' />  



<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306175304810.png" alt="image-20210306175304810"  width= "90%" align='left' />  



<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306175333211.png" alt="image-20210306175333211"  width= "10%" align='left' />  



​	成功！

​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306175715007.png" alt="image-20210306175715007"  width= "90%" align='left'/>  



<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306175728604.png" alt="image-20210306175728604"  width= "10%" align='left' />  



​	切换scheme，App名字被修改，证明配置成功。

​	这样我们就能给测试包的时候，不在被问是什么环境了！

## 三、根据多环境运行代码

​	<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306180043556.png" alt="image-20210306180043556" style="zoom:50%;" />  



​	相信说到Preprocessor Macros 大家一定不会陌生。

​	多环境中，可以根据设置的宏来改变代码流程。

​		<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306180525596.png" alt="image-20210306180525596"  width= "90%" align='left'/> 

 

​	





同样我们使用xcconfig来设置。 通过复制Preprocessor Macros 粘贴到xcconfig。可以拿到Key值，这样我们就能使用文本控制项目的配置了。

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306180747691.png" alt="image-20210306180747691"  width= "50%" align='left' />  



​	xcconfig配置完成后，运行项目会发现Preprocessor Macros 的值也发生了改变，再次证明我们使用xcconfig是会影响项目配置的。

<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306181156892.png" alt="image-20210306181156892"  width= "90%" align='left' />  



<img src="https://github.com/zhuxiaod/MarkDownImages/blob/master/img/image-20210306181135918.png" alt="image-20210306181135918"  width= "90%" align='left' />  



​	这样就满足了我相同的逻辑在多环境，不同的实现。

​	

## 结尾

​	网上对于多环境有很多好的帖子，讲的十分详细，笔者这里是综合自己的使用需求写的笔记。如果有朋友要想了解更多可以去网上搜索相关内容。

​	

​	参考：

​	[手把手教你给一个iOS app配置多个环境变](https://www.jianshu.com/p/83b6e781eb51)



​	
