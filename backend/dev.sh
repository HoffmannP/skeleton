#!/bin/bash

watchmedo auto-restart --pattern  "*.py" --recursive --signal SIGTERM python3 server.py