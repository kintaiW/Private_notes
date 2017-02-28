##WebMagic初探
---

###1. maven <-> gradle 相互转化
####1.1 gradle <-> maven
* 比较繁琐,[详见](http://www.cnblogs.com/yjmyzz/p/gradle-to-maven.html)

####1.2 maven <-> gradle
* __$__:gradle init --type pom
* 编译WebMagic 失败,原因待查,初步认为Classpath配置没添加

###2. 依靠 *build.gradle* 成功运行
* Gradle构建,导入WebMagic jar包相关依赖
    <div class="sourceCode"><pre class="prettyprint">
      apply plugin: 'java'
      repositories {
        mavenCentral()
      }
      dependcies {
        compile (
          "us.codecraft:webmagic-core:0.6.1",
          "us.codecraft:webmagic-extension:0.6.1",
          files('$HOME/.m2/repository/us/codecraft')
         )
      }
      task run(type: JavaExec, dependsOn: 'classes') {
        description '运行指定main函数'
        classpath = sourceSets.main.runtimeClasspath
        if( project.hasProperty("main")){
          main = "${project.getProperty('main')}"
        }
      }
      task init << {
        description '初始化工程目录'
        sourceSets*.java.srcDirs*.each { it.mkdirs() }
        sourceSets*.resources.srcDirs*.each { it.mkdirs() }
      }
    </pre></div>
