#!/bin/bash
set -euo pipefail

if [ -d "hefs" ]; then
    echo "Deleting existing 'hefs' directory..."
    rm -rf hefs
fi

if [ -d "decoder_assets" ]; then
    echo "Deleting existing 'decoder_assets' directory..."
    rm -rf decoder_assets
fi

mkdir -p hefs/h8/tiny hefs/h8l/tiny hefs/h8/base hefs/h8l/base
mkdir -p decoder_assets/tiny/decoder_tokenization decoder_assets/base/decoder_tokenization

echo "Downloading HEFs for Hailo-8 tiny..."
wget -q -P hefs/h8/tiny "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8/tiny-whisper-decoder-fixed-sequence-matmul-split.hef"
wget -q -P hefs/h8/tiny "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8/tiny-whisper-encoder-10s_15dB.hef"

echo "Downloading HEFs for Hailo-8L tiny..."
wget -q -P hefs/h8l/tiny "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8l_rpi/tiny-whisper-decoder-fixed-sequence-matmul-split_h8l.hef"
wget -q -P hefs/h8l/tiny "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8l_rpi/tiny-whisper-encoder-10s_15dB_h8l.hef"

echo "Downloading HEFs for Hailo-8 base..."
wget -q -P hefs/h8/base "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8/base-whisper-decoder-fixed-sequence-matmul-split.hef"
wget -q -P hefs/h8/base "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8/base-whisper-encoder-5s.hef"

echo "Downloading HEFs for Hailo-8L base..."
wget -q -P hefs/h8l/base "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8l_rpi/base-whisper-decoder-fixed-sequence-matmul-split_h8l.hef"
wget -q -P hefs/h8l/base "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/hefs/h8l_rpi/base-whisper-encoder-5s_h8l.hef"

echo "Downloading decoder assets for tiny model..."
wget -q -P decoder_assets/tiny/decoder_tokenization "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/npy%20files/whisper/decoder_assets/tiny/decoder_tokenization/onnx_add_input_tiny.npy"
wget -q -P decoder_assets/tiny/decoder_tokenization "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/npy%20files/whisper/decoder_assets/tiny/decoder_tokenization/token_embedding_weight_tiny.npy"

echo "Downloading decoder assets for base model..."
wget -q -P decoder_assets/base/decoder_tokenization "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/npy%20files/whisper/decoder_assets/base/decoder_tokenization/onnx_add_input_base.npy"
wget -q -P decoder_assets/base/decoder_tokenization "https://hailo-csdata.s3.eu-west-2.amazonaws.com/resources/npy%20files/whisper/decoder_assets/base/decoder_tokenization/token_embedding_weight_base.npy"

echo "Download complete."
