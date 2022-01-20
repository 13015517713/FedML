# str = '--gpu 0 --dataset mnist --data_dir ./../../../data/mnist --model lr --partition_method hetero --client_num_in_total 2 --client_num_per_round 2 --comm_round 1 --epochs 1 --batch_size 4 --client_optimizer sgd --lr 0.03 --ci 1'
str = "--gpu_mapping_file gpu_mapping.yaml --gpu_mapping_key mapping_default --model lr --dataset mnist --data_dir ./../../../data/mnist --partition_method hetero --client_num_in_total 2 --client_num_per_round 2 --comm_round 1 --epochs 1 --client_optimizer sgd --batch_size 4 --lr 0.03 --ci 1 "
str = str.replace(' ', '", "')
print(str)