# I forgot what article about the ips_mode patch thing
# but credits to him for providing this.
echo "options rtl8188fu rtw_power_mgnt=0 rtw_enusbss=0 rtw_ips_mode=0" | sudo tee /etc/modprobe.d/rtl8188fu.conf`
