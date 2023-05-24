FROM alpine:3.18

RUN apk update
RUN apk add neovim nodejs ripgrep
ADD . /root/.config/nvim 
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' -c 'MasonUpdate' +qa
