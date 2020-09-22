local model_name = "bert-base-uncased";
{
  "dataset_reader": {
    "type": "vqav2",
    "image_dir": "/net/nfs2.corp/prior/datasets/coco",
    "feature_cache_dir": "test_fixtures/data/vqav2/images/experiment_cache",
    "image_loader": "detectron",
    "image_featurizer": "resnet_backbone",
    "region_detector": "faster_rcnn",
    "tokenizer": {
      "type": "pretrained_transformer",
      "model_name": model_name
    },
    "token_indexers": {
      "tokens": {
        "type": "pretrained_transformer",
        "model_name": model_name
      }
    }
  },
  "vocabulary": {"type": "empty"},
  "train_data_path": "balanced_real_train",
  "validation_data_path": "balanced_real_val",
  "model": {
    "type": "vqa_vilbert_from_huggingface",
    "model_name": model_name,
    "image_feature_dim": 2048,
    "image_hidden_size": 1024,
    "image_num_hidden_layers": 12,
    "combined_hidden_size": 1024,
    "pooled_output_dim": 1024,
    "image_intermediate_size": 1024,
    "image_attention_dropout": 0.1,
    "image_hidden_dropout": 0.1,
    "v_biattention_id": [0, 1, 2, 3, 4, 5],
    "t_biattention_id": [6, 7, 8, 9, 10, 11],
    "fixed_t_layer": 0,
    "fixed_v_layer": 0,
    "fusion_method": "sum"
  },
  "data_loader": {
    "batch_size": 32
  },
  "trainer": {
    "optimizer": {
        "type": "huggingface_adamw",
        "lr": 0.00005
    },
    "validation_metric": "+denotation_acc",
    "num_epochs": 1,
  },
  "distributed": {
    "cuda_devices": [0,1]
  }
}