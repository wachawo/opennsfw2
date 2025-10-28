# Docker Guide for OpenNSFW2

# Docker Usage Examples

## Predict Image

```bash
mkdir -p data
cp image.jpg data/

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

## Quick Start

### With Docker Only

Build:
```bash
docker build -t opennsfw2:latest .
```

Run:
```bash
docker run -it --rm -v $(pwd)/data:/data opennsfw2:latest
```

### Import Pre-built Image

Save image to file:
```bash
docker save opennsfw2:latest -o opennsfw2.tar
```

Load image from file:
```bash
docker load -i opennsfw2.tar
```

Or import from tar archive:
```bash
cat opennsfw2.tar | docker import - opennsfw2:latest
```

### With Docker Compose

```bash
docker-compose build
docker-compose run --rm opennsfw2
```


## Usage Examples

### Predict Single Image

```bash
mkdir -p data
cp your_image.jpg data/
docker-compose run --rm opennsfw2 python -c "import opennsfw2 as n2; print(n2.predict_image('/data/your_image.jpg'))"
```

### Run Python Script

Create `predict.py`:
```python
import opennsfw2 as n2
print(n2.predict_image('/data/test_image.jpg'))
```

Run it:
```bash
docker-compose run --rm opennsfw2 python predict.py
```

### Interactive Shell

```bash
docker-compose run --rm opennsfw2
```

## GPU Support (Optional)

1. Install [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
2. Uncomment GPU section in `docker-compose.yml`
3. Rebuild: `docker-compose build`

## Clean Up

```bash
docker-compose down
docker rmi opennsfw2:latest
```


