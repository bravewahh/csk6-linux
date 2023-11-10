import os
import sys
import subprocess
import argparse

# 检查当前目录是否为Git仓库
def is_git_repository(dir):
    return os.path.exists(dir+'/.git')

# 克隆指定的Git仓库并切换到指定的commit
def clone_and_checkout_repository(repo_url, local_path, commit):

    if not os.path.exists(local_path):
        print("Source directory does not exist, create directory:"+local_path)
        os.makedirs(local_path)

    subprocess.run(['git', '-C', local_path, 'clone', repo_url, local_path])
    fetch_and_checkout_commit(local_path,commit)

# 获取Git仓库的更新并切换到指定的commit
def fetch_and_checkout_commit(local_path,commit):
    subprocess.run(['git', '-C', local_path, 'fetch', '--all'])
    subprocess.run(['git', '-C', local_path, 'checkout', '--detach', commit])

parser = argparse.ArgumentParser(
    description='git checkout to commit.')
parser.add_argument('--remote', '-r', help='git remote repository url', default='')
parser.add_argument('--local', '-l', help='git local directory', default='')
parser.add_argument('--commit', '-m', help='git commit or branches', default='')

args = parser.parse_args()

if __name__ == '__main__':

    if is_git_repository(args.local):
        print('git checkout commit ' + args.commit)
        fetch_and_checkout_commit(args.local,args.commit)
    else:
        print('git clone url ' + args.remote,'commit:'+args.commit)
        clone_and_checkout_repository(args.remote, args.local, args.commit)
