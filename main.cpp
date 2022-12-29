#include <cstdlib>
#include <fstream>
#include <vector>
#include <array>
#include <random>
#include <ranges>
#include <chrono>
#include <iostream>
#include <cstdlib>

constexpr unsigned long size = 100 * 1024 * 1024 / 4;

extern "C" void lightQsort(int* data, unsigned long size);

int main()
{
    std::vector<int> data(size);
    std::default_random_engine rd;
    std::uniform_int_distribution<int> distr;

    std::cout << "gen start" << std::endl;
    for (int &val : data)
        val = distr(rd);
    std::cout << "gen end" << std::endl;

    std::cout << "lightQsort..." << std::endl;
    auto start = std::chrono::high_resolution_clock::now();
    lightQsort(data.data(), data.size());
    std::chrono::duration<double> elapsed = std::chrono::high_resolution_clock::now() - start;
    std::cout << "elapsed time (s): " << elapsed.count() << std::endl;

    std::cout << "gen start" << std::endl;
    for (int &val : data)
        val = distr(rd);
    std::cout << "gen end" << std::endl;

    std::cout << "std::sort..." << std::endl;
    start = std::chrono::high_resolution_clock::now();
    std::qsort(data.data(), data.size(), 4,
        [](const void* a, const void* b)
        { return *(int*)a-*(int*)b; });
    elapsed = std::chrono::high_resolution_clock::now() - start;
    std::cout << "elapsed time (s): " << elapsed.count() << std::endl;

    return 0;
}
