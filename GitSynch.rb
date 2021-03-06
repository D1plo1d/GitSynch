require("yaml")

#Allows easy, single command synchronization of folders across multiple machines using git.
#Note that this is inherently a simplification of git's power and is really only intended for 
#a single user who needs to move between machines easily.
class GitSynch
  def initialize(folder, remote, branch)
    @folder = folder
    @remote = remote
    @branch = branch
  end
  
  #synchronizes the folder with the remote repo. Returns false if this fails.
  def synchronize
    #TODO: init if needed
    #@repo.init(dir)
    #incomming => pull, merge [TODO: merge as needed]
    puts system("cd "+@folder+"; git pull "+@remote+" "+@branch) #TODO: pure ruby
    #outgoing => add, commit, push
    puts system("cd "+@folder+"; git add .")
    puts system('cd '+@folder+'; git commit -a -m"[GitSynch] automated commit"')
    puts system("cd "+@folder+"; git push "+@remote+" "+@branch) #TODO: pure ruby
  end
end

YAML::load(File.read("config.yaml"))["folders"].each {|file|
    GitSynch.new(file, "origin", "master").synchronize
  }
