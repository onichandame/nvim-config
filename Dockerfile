FROM alpine:3.18

RUN apk update
RUN apk add neovim neovim-doc nodejs ripgrep git gcc libstdc++-dev g++
ADD . /root/.config/nvim 
RUN nvim --headless "+Lazy! sync" +qa
