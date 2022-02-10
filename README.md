# 简介

> 本docker镜像基于 `autodock vina 1.2.3` 在 `ubuntu20.04` 上的默认版本`python3.8`构建。
> 
> [官方网站](https://vina.scripps.edu/)
> 
> 该项目针对不方便构建`autodock vina`环境的科研工作者使用。注意，本docker镜像仓库并没有得到官方的授权。
> 
> 构建本镜像的原因在于，在目前截止2022.02.10. 官方并没有退出windows版本的python 
> bindings。从源码构建，似乎需要从源头的C++进行构建。并未成功。在macos(x
> 86)与ubuntu(debin)上更容易构建。考虑到大多数都是服务器进行对接筛选小分子，这里便构建了本镜像。方便可以使用python多进程进行调用对接，进行大规模的药物筛选。
> `apt`使用了阿里云镜像,`pip`使用清华源，国外用户自行修改。

# 快速使用

## 安装docker

[install docker](https://www.docker.com/get-started)

## 使用Dockerfile构建镜像

由于使用root密码登录不安全镜像使用了秘钥认证，克隆或者下载本仓库后请构建镜像之前替换本仓库中`config/id_rsa.pub`为你**自己的公钥**。

执行以下命令
```shell
cd dockervina
docker build -t my_vina . # 设置国内dockerhub官方镜像
```

启动镜像
```shell
docker run --name jupyterhub -p 0.0.0.0:6006:22/tcp my_vina /bin/bash
```

高级启动镜像(参考)
```shell
docker run --name jupyterhub --cpuset-cpus="0-6" --memory 16g --memory-swap 32g --kernel-memory 4g --volume //d/jupyterhub:/home/spawner -p 0.0.0.0:8007:22/tcp -p 0.0.0.0:8888:8000 -d hotwa/jupyterhub:v5.2 /bin/bash
```

ssh登录
port : 6006 # 启动时可以自行替换

测试
```shell
cd /home/root
sudo chmod +x ./first_example.py
python ./first_example.py
```

结果

```shell
root@53c6b9347b98:~# cd /home/root/
root@53c6b9347b98:/home/root# python first_example.py 
Computing Vina grid ... done.
Score before minimization: -12.513 (kcal/mol)
Performing local search ... done.
Score after minimization : -13.249 (kcal/mol)
Performing docking (random seed: 224664591) ... 
0%   10   20   30   40   50   60   70   80   90   100%
|----|----|----|----|----|----|----|----|----|----|
***************************************************

mode |   affinity | dist from best mode
     | (kcal/mol) | rmsd l.b.| rmsd u.b.
-----+------------+----------+----------
   1       -12.94          0          0
   2       -10.95      1.104      1.827
   3       -10.94      2.998      12.41
   4       -10.72      3.923      12.33
   5       -10.26      1.653      13.51
   6       -10.21      2.524      12.62
   7       -9.427      2.956      12.51
   8       -9.109      1.595      2.674
   9       -8.841      1.716      13.15
  10       -8.716        2.4      12.84
  11       -8.586      3.906      12.72
  12        -8.37      3.991      12.93
  13       -8.151      4.012      6.512
  14       -7.882      1.921      4.206
  15       -7.876      2.287      3.982
  16       -7.674      3.066      5.981
  17       -7.603       7.42       11.6
  18        -7.52      4.613      8.777
  19       -7.309      4.089      8.538
```

