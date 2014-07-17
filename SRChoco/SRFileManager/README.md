SRFileManager
=============

## SRDirectory

Get Files and Directories on my HOME directory:
<pre>
let home = SRDirectory(SRDirectory.pathForHome())
home.load()

for dir: SRDirectory in home.directories {
    println(dir)
}

for file: SRFile in home.files {
    println(file)
}
</pre>

Asynchronous Load for Big File-system:
<pre>
let home = SRDirectory(SRDirectory.pathForHome())
home.load() {
    for dir: SRDirectory in home.directories {
        println(dir)
    }

    for file: SRFile in home.files {
        println(file)
    }
}
</pre>

:-)
