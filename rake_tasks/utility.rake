desc "Generate ctags file for project"
task :tags do
  fail unless system("ctags -R .")
end

desc "Remove generated files and directories"
task :clean do
  Rake.application["clobber_rdoc"].invoke
  command = "rm -rf pkg"
  puts command; system(command)
end
