# GUEF
Generalized Uncertainty-Based Evidential Fusion with Hybrid Multi-Head Attention for Weak-Supervised Temporal Action Localization

## Source code
The code will be open after acceptance.

## Introduction
Weakly supervised temporal action localization (WS-TAL) is a task of targeting at localizing complete action instances and categorizing them with video-level labels. Action-background ambiguity, primarily caused by background noise resulting from aggregation and intra-action variation, is a significant challenge for existing WS-TAL methods. In this paper, we introduce a hybrid multi-head attention (HMHA) module and generalized uncertainty-based evidential fusion (GUEF) module to address the problem. The proposed HMHA effectively enhances RGB and optical flow features by filtering redundant information and adjusting their feature distribution to better align with the WS-TAL task. Additionally, the proposed GUEF adaptively eliminates the interference of background noise by fusing snippet-level evidences to refine uncertainty measurement and select superior foreground feature information, which enables the model to concentrate on integral action instances to achieve better action localization and classification performance. Experimental results conducted on the THUMOS14 dataset demonstrate that our method outperforms state-of-the-art methods.

## Prerequisites
### Requirements and Dependencies:
Here we list our used requirements and dependencies.
 - Linux: Ubuntu 22.04 LTS
 - GPU: GeForce RTX 4090
 - CUDA: 11.8
 - Python: 3.10
 - PyTorch: 2.0.1
 - Numpy
 - Pandas
 - Scipy
 - Wandb
 - Tqdm

### THUMOS-14 Dataset：
You can get access of the dataset from [Google Drive](https://drive.google.com/file/d/1SFEsQNLsG8vgBbqx056L9fjA4TzVZQEu/view?usp=sharing) or [Baidu Disk](https://pan.baidu.com/s/1nspCSpzgwh5AHpSBPPibrQ?pwd=2dej). The annotations are included within this package.

