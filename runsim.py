#! /usr/bin/env python

from multiprocessing import Pool
import subprocess
import time
import sys
import os.path



def run(i):
    print('Simulating trajectory\t{}'.format(i))
    start = time.time()
    t = subprocess.check_output("/usr/local/bin/matlab -nojvm -nodisplay -batch 'MV_scan_APC({})'".format(i), shell=True)
    
    print('Completed trajectory\t{} in \t{:.2f} s'.format(i, time.time() - start ) )



p = Pool(int(sys.argv[1]))
num = 200
start = time.time()
for index in range(num):
    p.apply_async(run, args=(index,))
    time.sleep(0.3);
p.close()
p.join()
print('Finished {} iterations in {:.2f} seconds.'.format(num, time.time() - start))
