#!/bin/bash

id=$(kitty @ new-window --cwd $(pwd))
kitty @ send-text -m id:$id 'cd backend\n'
kitty @ send-text -m id:$id './dev.sh\n'
kitty @ goto-layout vertical



cd frontend
yarn dev