DOTFILES_REPO = 'git://github.com/alpicola/dotfiles.git'
DOTFILES_DIR  = File.expand_path('~/repos/dotfiles')
DOTFILES = %w|.vim .vimrc .zsh .zshrc|

directory DOTFILES_DIR

file DOTFILES_DIR do |t|
  sh "git clone --recursive #{DOTFILES_REPO} #{DOTFILES_DIR}"
end

file DOTFILES => DOTFILES_DIR do |t|
  ln_sf File.join(DOTFILES_DIR, t.name), t.name 
end

task :default => :install

task :install => DOTFILES
