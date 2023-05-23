FROM archlinux

RUN pacman -Sy --noconfirm neovim git nodejs zig ripgrep
ADD . /root/.config/nvim 
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
