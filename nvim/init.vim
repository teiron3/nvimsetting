"=== normal settings ===
	set enc=utf-8
	set fenc=utf-8
	set number
	set nowrap

	set expandtab
	set tabstop=2
	set autoindent
	set shiftwidth=2
	set syntax=enable
	set hidden

	set noswapfile
	set nobackup
	set noundofile

	set foldmethod=indent "インデントで折り疂む

"=== key mapping ===
	let mapleader = "\<Space>"
	inoremap <silent> jj <ESC>
	nmap <Leader>? <Cmd>Cheat<CR>
	nmap <Leader>?e <Cmd>EditCheat<CR>
	command! EditCheat :edit ~/.config/nvim/cheatsheet

"=== dein setting ===
	let s:dein_dir = expand('~/.cache/dein')
	let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

	if &runtimepath !~# '/dein.vim'
		if !isdirectory(s:dein_repo_dir)
			execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
		endif
		execute 'set runtimepath^=' . s:dein_repo_dir
	endif

	if dein#load_state(s:dein_dir)
		call dein#begin(s:dein_dir)

		let s:rc_dir = expand('~/.config/nvim')
		if !isdirectory(s:rc_dir)
			call mkdir(s:rc_dir, 'p')
		endif

		let s:toml = s:rc_dir . '/dein.toml'
		let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

		call dein#load_toml(s:toml, {'lazy': '0'})
		call dein#load_toml(s:lazy_toml, {'lazy': '1'})

		call dein#end()
		call dein#save_state()
	endif

	if dein#check_install()
		call dein#install()
	endif

	let s:removed_plugins = dein#check_clean()
	if len(s:removed_plugins) > 0
		call map(s:removed_plugins, "delete(v:val, 'rf')")
		call dein#recache_runtimepath()
	endif

set statusline^=%{coc#status()}
