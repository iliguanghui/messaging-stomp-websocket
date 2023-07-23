#!/bin/bash
# 构建docker镜像
nerdctl -n k8s.io image build -t registry.cn-hangzhou.aliyuncs.com/lgypro/messaging-stomp-websocket:v1 .
