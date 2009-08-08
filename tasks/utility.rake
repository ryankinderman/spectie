desc "Generate ctags file for project"
task :tags do
  fail unless system("ctags -R .")
end
