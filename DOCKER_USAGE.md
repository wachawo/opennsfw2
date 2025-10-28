# Docker Usage Examples

## Predict Image

```bash
mkdir -p data
cp your_image.jpg data/

docker run -it --rm -v $(pwd)/data:/data -v $(pwd)/weights:/root/.opennsfw2/weights opennsfw2:latest python -c "
import opennsfw2 as n2
result = n2.predict_image('/data/image.jpg')
print(f'NSFW Probability: {result:.4f}')
"
```
## Predict Video

```bash
docker run -it --rm -v $(pwd)/data:/data -v $(pwd)/weights:/root/.opennsfw2/weights opennsfw2:latest python -c "
import opennsfw2 as n2

video_path = '/data/video.mp4'
elapsed_seconds, nsfw_probabilities = n2.predict_video_frames(video_path)

print(f'Total frames: {len(nsfw_probabilities)}')
print(f'Average NSFW probability: {sum(nsfw_probabilities)/len(nsfw_probabilities):.4f}')
"
```

