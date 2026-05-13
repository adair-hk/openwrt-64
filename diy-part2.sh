#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.4/g' package/base-files/files/bin/config_generate

# 针对 Lean 源码 (LEDE) 的最佳匹配：
rm -rf package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config

# Edge 皮肤
rm -rf package/lean/luci-theme-edge
git clone https://github.com/kiddin9/luci-theme-edge.git package/lean/luci-theme-edge

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 删除冲突源码（需要安装samba4使用）
rm -rf package/lean/autosamba

#双重保险
echo "CONFIG_PACKAGE_autosamba=n" >> .config
sed -i 's/CONFIG_PACKAGE_autosamba=y/CONFIG_PACKAGE_autosamba=n/g' .config
