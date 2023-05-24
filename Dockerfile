FROM archlinux:base-devel

RUN pacman -Sy --noconfirm neovim git nodejs npm zig ripgrep
ADD . /root/.config/nvim 
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' -c 'MasonUpdate'
